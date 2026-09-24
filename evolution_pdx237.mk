#
# Copyright (C) 2018 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit product makefiles (most specific last)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Evolution / Lineage
WITH_GMS := true
$(call inherit-product, vendor/lineage/config/common_mobile_full.mk)
$(call inherit-product, vendor/lineage/config/telephony.mk)

# Evolution features
EVO_BUILD_TYPE := Unofficial
IS_PHONE := true
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_ENABLE_BLUR := true
TARGET_SUPPORTS_QUICK_TAP := true

PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode?=true

# Device identity
PRODUCT_NAME := evolution_pdx237
PRODUCT_DEVICE := pdx237
PRODUCT_MANUFACTURER := Sony
PRODUCT_BRAND := Sony
PRODUCT_MODEL := Xperia 5 V
PRODUCT_GMS_CLIENTID_BASE := android-sonymobile

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="XQ-DE72-user 15 67.2.A.3.178 067002A003017800523109309 release-keys" \
    BuildFingerprint=Sony/XQ-DE72/XQ-DE72:15/67.2.A.3.178/067002A003017800523109309:user/release-keys \
    DeviceName=XQ-DE72 \
    DeviceProduct=XQ-DE72 \
    SystemDevice=XQ-DE72 \
    SystemName=XQ-DE72
