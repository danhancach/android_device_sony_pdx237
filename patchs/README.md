# pdx237 — hub bản vá ROM (device-bound)

Bản vá mã nguồn ROM **phục vụ thiết bị pdx237 / Sony / sm8550**. Commit cùng device tree lên GitHub.

Device tree sibling (không chứa bản vá ROM trùng): [RELATED.md](RELATED.md).

## Apply sau sync ROM

Từ root AOSP:

```bash
device/sony/pdx237/patchs/apply.sh
```

Idempotent (`git apply --check --reverse`). Chỉ apply các file trong hub này theo `series.txt`.

## Thứ tự (`series.txt`)

1. `system/media` — FCC 360RA  
2. `frameworks/av` — Sony 0001–0003 + prefer-builtin-mic  
3. `frameworks/base` — disable-audio-hardening  
4. `hardware/qcom-caf/sm8550/...` — haptic HAL + display  
5. `system/vold` — exFAT Sony utils  
6. `packages/apps/Settings`, `LineageParts` — Xperia battery / charging  

## Cấu trúc

```
patchs/
  README.md
  RELATED.md
  apply.sh
  series.txt
  frameworks/ …
  system/ …
  hardware/qcom-caf/sm8550/ …
  packages/ …
```

## Thêm / cập nhật bản vá

1. Sửa trong rom tree → `git diff` → `patchs/<mirror-path>/<mo-ta>.patch`
2. Thêm dòng vào `series.txt`
3. Commit trên `device/sony/pdx237`; cập nhật [RELATED.md](RELATED.md) nếu stack sibling đổi
4. Repo khác chỉ **link** hub / RELATED — không giữ bản vá ROM trùng online

Jelly / SystemUIClocks-Flex: gỡ bằng `RemovePackages` trên device tree — không dùng patch trong hub này.
