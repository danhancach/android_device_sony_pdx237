# Related commits (không chứa bản vá ROM trùng)

Hub này chỉ áp rom tree **device-bound** qua `apply.sh`. Stack ringtone / haptic / Dolby còn cần commit trên device / vendor / kernel / hardware dưới đây.

## Ringtone / haptic stack

| Vai trò | Repo | Path / subject | Hash (hiện tại) |
|---------|------|----------------|-----------------|
| fw/av Sony port (dlb_ring + ringtone no DAP on haptic) | *hub này* | `frameworks/av/0001`–`0003` | tip hub: `git -C device/sony/pdx237 log -1 --oneline -- patchs` |
| CAF HAL haptic ASP / deep buffer / setVolume | *hub này* | `hardware/qcom-caf/.../fix-haptic-*.patch` | cùng tip hub |
| device: Dolby DAP + Pixel ringtone CS40 | [`device/sony/sm8550-common`](https://github.com/danhancach/android_device_sony_sm8550-common) (`evox`) | DVL music-only (stock); Pixel CS40 ASP path | `a7cc96c` |
| vendor blobs: CAF HAL + pal | [`vendor/sony/sm8550-common`](https://github.com/danhancach/proprietary_vendor_sony_sm8550-common) (`evox`) | prefer CAF audio HAL and pal-impl | xem tip `evox` |
| vendor blobs: Cirrus DVS keep haptic | cùng repo | keep haptic / speaker-safe tip audio path | xem tip `evox` |
| vibrator HAL MI2S | [`hardware/sony`](https://github.com/danhancach/hardware_sony) (`evox`) | share MI2S; LIGHT haptic | xem tip `evox` |
| kernel CS40 ASP | [`kernel/sony/sm8550-modules`](https://github.com/danhancach/android_kernel_sony_sm8550-modules) (`evox`) | cs40l2x safe ASP enable | xem tip `evox` |
| kernel DTS boost | [`kernel/sony/sm8550-devicetrees`](https://github.com/danhancach/android_kernel_sony_sm8550-devicetrees) (`evox`) | raise CS40 boost-ipk | xem tip `evox` |

## vendor/sony/audio

| Vai trò | Ghi chú |
|---------|---------|
| Proprietary Dolby / 360RA / DSEE / SoundEnhancement | Repo [`vendor/sony/audio`](https://github.com/danhancach/proprietary_vendor_sony_audio) branch `pdx237` |
| Bản vá ROM frameworks/av + system/media | Chỉ pointer tới hub `device/sony/pdx237/patchs` + `apply.sh` |
| SoundEnhancement whitelist 33 | `soundenhancement/patches/apply.sh` (device tree) |

## Ghi chú

- Việc đã commit trên device tree (whitelist, sepolicy, RemovePackages, …) không cần bản vá trong hub.
- Hash sibling: `git rev-parse` / `git log -1` trên từng repo. Tip hub: `git -C device/sony/pdx237 log -1 --oneline -- patchs`.
