# Related — sibling ngoài hub

Hub (`series.txt` + `apply.sh`) chỉ chứa bản vá **rom tree** device-bound.
Dưới đây là repo sibling hoàn thiện cùng stack — **không** nhân bản `.patch` ROM.

## Audio / ringtone / haptic

| Vai trò | Repo (`evox` trừ khi ghi khác) | Ghi chú |
|---------|--------------------------------|---------|
| Primary HAL (haptic, bridge, hi-res, speaker-safe) | [`android_hardware_qcom_audio-ar`](https://github.com/danhancach/android_hardware_qcom_audio-ar) → `hardware/qcom-caf/sm8550/audio/primary-hal` | **SSOT fork** — không có `*.patch` trong hub |
| Device: DAP / CS40 ringtone / SPEAKER_SAFE deep-buffer / EC stub / whitelist | [`device/sony/sm8550-common`](https://github.com/danhancach/android_device_sony_sm8550-common) | `speaker_safe_out`; `ext_ec_ref_tx` rỗng; `audio_app_white_list.xml` |
| Vendor: tắt prebuilt `audio.primary.kalama`; Cirrus DVS haptic | [`vendor/sony/sm8550-common`](https://github.com/danhancach/proprietary_vendor_sony_sm8550-common) | SSOT HAL = fork CAF |
| Vibrator HAL MI2S | [`hardware/sony`](https://github.com/danhancach/hardware_sony) | |
| Kernel CS40 ASP | [`kernel/sony/sm8550-modules`](https://github.com/danhancach/android_kernel_sony_sm8550-modules) | |
| Kernel DTS CS40 boost | [`kernel/sony/sm8550-devicetrees`](https://github.com/danhancach/android_kernel_sony_sm8550-devicetrees) | |
| Proprietary Dolby / 360RA / DSEE / SoundEnhancement | [`vendor/sony/audio`](https://github.com/danhancach/proprietary_vendor_sony_audio) (`pdx237`) | Chỉ blobs / configs / sepolicy |

Hub liên quan (xem `series.txt`): `frameworks/av/0001`–`0004`, APM SPEAKER_SAFE, `system/media` FCC 360RA.
`frameworks/base` audio hardening và SPEAKER_SAFE sync thuộc fork `danhancach/frameworks_base` (`cnb`), không có patch trùng trong hub.

Mode transition / anti-pop (cùng `hardware/sony` SoundEnhancement + `vendor/sony/audio/DSEE` `invalidate_sleep_*`): `0001` settle khi `dsee_hx_state=0`; `0004` giữ Dolby HAL khi DMS reconnect.

`0001` EffectDapController: không gửi `SET_BYPASS` / `SKIP_HARD_BYPASS` xuống `libswdap` (blob reject). Bypass qua `mBypassed` + HAL `dle_ds_state`.

## Speaker mono (portrait built-in speakers)

- Framework request and display rotation: fork `danhancach/frameworks_base`,
  `frameworks/base`; no duplicate framework patch in this hub.
- Output policy and DIRECT PCM blending: `frameworks/av/0005-speaker-portrait-mono.patch`.
  Custom mono applies only to built-in speaker/speaker-safe outputs.
- Preference and Quick Settings tile: `hardware/sony`, SoundEnhancement.
- Service ownership: `vendor/sony/audio`, daxService no longer writes Accessibility
  `master_mono`; original Dolby rotation tuning remains.

These components require a coherent framework, JNI, native audio, and app build.
Host checks do not validate device playback or AAudio/offload reconnection.
