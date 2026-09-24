#!/usr/bin/env bash
# Hub apply device-bound ROM patches (Sony/sm8550/pdx237).
# Idempotent: git apply --check --reverse -> da apply thi bo qua.
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
    if git -C "$repo" apply --check "$patch" >/dev/null 2>&1; then
        if git -C "$repo" apply "$patch"; then
            echo "applied: $patch_rel"
            applied=$((applied + 1))
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
