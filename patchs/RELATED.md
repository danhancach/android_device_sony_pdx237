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

Hub liên quan (xem `series.txt`): `frameworks/av/0001`–`0003`, APM SPEAKER_SAFE, `frameworks/base` SPEAKER_SAFE sync, `system/media` FCC 360RA.

`0001` EffectDapController: không gửi `SET_BYPASS` / `SKIP_HARD_BYPASS` xuống `libswdap` (blob reject). Bypass qua `mBypassed` + HAL `dle_ds_state`.
