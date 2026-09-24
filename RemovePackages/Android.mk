#
# Copyright (C) 2022-2023 VoidUI Project
#
# SPDX-License-Identifier: Apache-2.0
#
# Goi gms_mini van ship: PrebuiltBugle, GoogleDialer, CalendarGooglePrebuilt,
# GoogleContacts, PrebuiltDeskClockGoogle, CarrierLocation, ...
# Chi override goi AOSP trung / GMS khong muon (Chrome, DIN, ...).
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := RemovePackages
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := \
    ANGLE \
    AmbientSensePrebuilt \
    AppDirectedSMSService \
    Aperture \
    AudioFX \
    BetterBugStub \
    Browser2 \
    Calendar \
    Chrome \
    Chrome.apk.gz \
    Chrome-Stub \
    Contacts \
    DeskClock \
    DeviceIntelligenceNetworkPrebuilt \
    DeviceIntelligenceNetworkPrebuiltAstrea \
    Gallery2 \
    GCS \
    GoogleCamera \
    Jelly \
    LatinIME \
    MetroLauncher \
    MetroLauncherSideload \
    MetroLauncherSpec \
    MetroLauncherSpecSideload \
    Music \
    MusicFX \
    NewLauncherSideload \
    PlayAutoInstallConfig \
    SCONE \
    SCONE-v69510 \
    SCONE-v77459 \
    SomcCameraApp-Chikugo \
    SystemUIClocks-Flex \
    SoundEnhancementPDX237 \
    XperiaAudioAddon \
    XperiaAudioDTS \
    XperiaAudioPlus \
    XperiaAudioPlusOverlay \
    XperiaTSRA

LOCAL_UNINSTALLABLE_MODULE := true
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := /dev/null
include $(BUILD_PREBUILT)
