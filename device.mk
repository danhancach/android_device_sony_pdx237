#
# Copyright (C) 2018 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Feature flags (set before inheriting common — common.mk may override defaults)
# SomcCameraApp-Chikugo does not work on pdx237; keep Pro camera extras.
TARGET_SHIPS_SONY_CAMERA_APP := false
TARGET_SUPPORTS_360RA := true
TARGET_SUPPORTS_SOUND_ENHANCEMENT_ADDON := false
TARGET_SUPPORTS_SOUND_ENHANCEMENT_DTS := false
TARGET_SHIPS_SOUND_ENHANCEMENT := false

# Evolution userdebug sets PRODUCT_NOT_DEBUGGABLE_IN_USERDEBUG → ro.debuggable=0,
# adb root/remount không hoạt động. Bật để dev push system_ext (m XperiaDisplay).
WITH_ADB_INSECURE := true

# Inherit sm8550-common
$(call inherit-product, device/sony/sm8550-common/common.mk)

# Overrides after common.mk
TARGET_SUPPORTS_SOUND_ENHANCEMENT_ADDON := false
AUDIO_FEATURE_ENABLED_LSM_HIDL := false

# Display
TARGET_SCREEN_HEIGHT := 2520
TARGET_SCREEN_WIDTH := 1080
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# HIDL base (device-specific)
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0

# NFC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfc/libnfc-nxp-typef.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp-typef.conf

# Overlays (RRO)
PRODUCT_PACKAGES += \
    ApertureResTarget \
    EvolutionSettingsResTarget \
    SonyPDX237NfcNciRes \
    SonyPDX237SystemUIRes

DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-evolution

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Remove unwanted AOSP/GMS/Sony packages (see RemovePackages/Android.mk)
PRODUCT_PACKAGES += \
    RemovePackages \
    disable_audio_hardening.sh \
    init.pdx237.rc

# Sony extras
TARGET_SHIPS_SONY_FRAMEWORK := true
TARGET_SHIPS_SONY_CAMERA := true
TARGET_SUPPORTS_GAME_CONTROLLERS := true
TARGET_SUPPORTS_XPERIA_STREAM := true
TARGET_SHIPS_XPERIA_LWP_SELECTED := true
TARGET_XPERIA_LWP_VERSION := LWP-5V

$(call inherit-product, vendor/sony/extra/Common/apps/apps.mk)
$(call inherit-product, vendor/sony/extra/Yodo/extra.mk)

# Vendor blobs
$(call inherit-product, vendor/sony/pdx237/pdx237-vendor.mk)

# Strip Sony Yodo Dolby stack (use vendor/sony/audio stock A15 port instead)
PRODUCT_PACKAGES := $(filter-out \
    DolbySound \
    SoundEnhancementPDX237 \
    XperiaAudioAddon \
    XperiaAudioDTS \
    XperiaAudioPlus \
    XperiaAudioPlusOverlay \
    XperiaTSRA \
    vendor.dolby.hardware.dms@2.0-service \
    vendor.dolby.hardware.dms@2.0-impl \
    vendor.dolby.hardware.dms@2.0_prebuilt \
    vendor.dolby.hardware.dms.xml \
    vendor.dolby.media.c2@1.0-service.xml,$(PRODUCT_PACKAGES))

# Sony stock A15 audio (Dolby via vendor/sony/audio)
$(call inherit-product, vendor/sony/audio/config.mk)

# KT VoLTE (imported device + Korea SIM)
$(call inherit-product, device/sony/pdx237/volte-kt.mk)

# Play Integrity defaults (used when Settings.Secure spoof config is empty after flash)
# Ship on product + vendor: vendor survives partial OTA/push; vendor path is secondary fallback in framework.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/evolution/pif.json:$(TARGET_COPY_OUT_PRODUCT)/etc/evolution/pif.json \
    $(LOCAL_PATH)/prebuilt/evolution/keybox.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/evolution/keybox.xml \
    $(LOCAL_PATH)/prebuilt/evolution/trickystore_targets.txt:$(TARGET_COPY_OUT_PRODUCT)/etc/evolution/trickystore_targets.txt \
    $(LOCAL_PATH)/prebuilt/evolution/trickystore_patch.txt:$(TARGET_COPY_OUT_PRODUCT)/etc/evolution/trickystore_patch.txt \
    $(LOCAL_PATH)/prebuilt/evolution/pif.json:$(TARGET_COPY_OUT_VENDOR)/etc/evolution/pif.json \
    $(LOCAL_PATH)/prebuilt/evolution/keybox.xml:$(TARGET_COPY_OUT_VENDOR)/etc/evolution/keybox.xml \
    $(LOCAL_PATH)/prebuilt/evolution/trickystore_targets.txt:$(TARGET_COPY_OUT_VENDOR)/etc/evolution/trickystore_targets.txt \
    $(LOCAL_PATH)/prebuilt/evolution/trickystore_patch.txt:$(TARGET_COPY_OUT_VENDOR)/etc/evolution/trickystore_patch.txt
