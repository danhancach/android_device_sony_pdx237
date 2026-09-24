#!/usr/bin/env bash
# Hub apply device-bound ROM patches (Sony/sm8550/pdx237).
# Commit-first recovery: uu tien `git am` (tao commit), khong de dirty WT.
# Idempotent: apply --check --reverse -> da co effect thi bo qua.
# Chi file trong hub nay + series.txt. Chi rom tree (khong device tree).
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
SERIES="${HERE}/series.txt"

# Tim root AOSP (frameworks/av/.git hoac build/envsetup.sh)
ROOT="$HERE"
while [[ "$ROOT" != / ]]; do
    if [[ -d "$ROOT/frameworks/av/.git" ]] || [[ -f "$ROOT/build/envsetup.sh" ]]; then
        break
    fi
    ROOT="$(cd "$ROOT/.." && pwd)"
done

if [[ ! -d "$ROOT/frameworks/av/.git" ]] && [[ ! -f "$ROOT/build/envsetup.sh" ]]; then
    echo "ERROR: khong tim thay root AOSP (dung tai $ROOT)" >&2
    exit 1
fi

echo "AOSP root: $ROOT"
echo "Hub: $HERE"
echo

applied=0
already=0
failed=0
skipped=0

# Commit tu mailbox patch khi am that bai nhung apply OK (fallback).
commit_from_patch() {
    local repo="$1"
    local patch="$2"
    local subject author email
    subject="$(sed -n 's/^Subject: \[PATCH[^]]*\] *//p' "$patch" | head -1)"
    [[ -z "$subject" ]] && subject="$(basename "$patch" .patch)"
    author="$(sed -n 's/^From: //p' "$patch" | head -1)"
    if [[ -n "$author" ]]; then
        git -C "$repo" -c user.name="$(sed 's/ <.*//' <<<"$author")" \
            -c user.email="$(sed -n 's/.*<\([^>]*\)>.*/\1/p' <<<"$author")" \
            commit --author="$author" -m "$subject" >/dev/null
    else
        git -C "$repo" commit -m "$subject" >/dev/null
    fi
}

apply_one() {
    local repo_rel="$1"
    local patch_rel="$2"
    local repo="$ROOT/$repo_rel"
    local patch="$HERE/$patch_rel"
    local name
    name="$(basename "$patch_rel")"

    if [[ ! -f "$patch" ]]; then
        echo "FAIL missing patch: $patch_rel"
        failed=$((failed + 1))
        return 0
    fi
    if [[ ! -d "$repo/.git" ]] && [[ ! -e "$repo/.git" ]]; then
        echo "SKIP no git repo: $repo_rel ($name)"
        skipped=$((skipped + 1))
        return 0
    fi

    if git -C "$repo" apply --check --reverse "$patch" >/dev/null 2>&1; then
        echo "already: $patch_rel"
        already=$((already + 1))
        return 0
    fi

    # Uu tien git am — tao commit, chiu duoc rebase sau nay
    if git -C "$repo" am --3way --committer-date-is-author-date "$patch" >/dev/null 2>&1; then
        echo "applied(am): $patch_rel"
        applied=$((applied + 1))
        return 0
    fi
    git -C "$repo" am --abort >/dev/null 2>&1 || true

    if git -C "$repo" apply --check "$patch" >/dev/null 2>&1; then
        if git -C "$repo" apply "$patch"; then
            # Stage file trong patch roi commit (van commit-first artifact)
            local files
            files="$(git -C "$repo" apply --numstat "$patch" 2>/dev/null | awk '{print $3}' | sed '/^$/d')"
            if [[ -n "$files" ]]; then
                # shellcheck disable=SC2086
                git -C "$repo" add -- $files 2>/dev/null || git -C "$repo" add -u
            else
                git -C "$repo" add -u
            fi
            if commit_from_patch "$repo" "$patch"; then
                echo "applied(commit): $patch_rel"
                applied=$((applied + 1))
            else
                echo "FAIL commit: $patch_rel"
                failed=$((failed + 1))
            fi
        else
            echo "FAIL apply: $patch_rel"
            failed=$((failed + 1))
        fi
        return 0
    fi
    echo "FAIL check: $patch_rel"
    failed=$((failed + 1))
}

# Doc series.txt
while IFS= read -r line || [[ -n "$line" ]]; do
    # Bo comment / dong trong
    [[ -z "${line// }" ]] && continue
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    repo_rel="${line%%|*}"
    patch_rel="${line#*|}"
    apply_one "$repo_rel" "$patch_rel"
done < "$SERIES"

echo
echo "--- summary ---"
echo "applied=$applied already=$already skipped=$skipped failed=$failed"
if [[ "$failed" -gt 0 ]]; then
    exit 1
fi
exit 0
