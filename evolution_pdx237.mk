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
# Jelly / SystemUIClocks-Flex: go bang RemovePackages (khong dung TARGET_INCLUDE_* — flag chet)
# Stock XQ-DE72 identity, platform ver 17 (khong mustang, khong FP userdebug tu nhien)
TARGET_ENABLE_FP_OVERRIDE := false
$(call inherit-product, vendor/lineage/config/common_mobile_full.mk)
$(call inherit-product, vendor/lineage/config/telephony.mk)
$(call inherit-product, $(LOCAL_PATH)/gms.mk)

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

# ro.system.build.fingerprint uses PRODUCT_SYSTEM_* (not BuildFingerprint override)
PRODUCT_SYSTEM_BRAND := Sony
PRODUCT_SYSTEM_NAME := XQ-DE72
PRODUCT_SYSTEM_DEVICE := XQ-DE72
PRODUCT_SYSTEM_MODEL := XQ-DE72
PRODUCT_SYSTEM_MANUFACTURER := Sony

# Full stock FP — PRODUCT_SYSTEM_* alone still leaves platform id/incremental/tags
PRODUCT_SYSTEM_PROPERTIES += \
    ro.system.build.fingerprint=Sony/XQ-DE72/XQ-DE72:17/67.2.A.3.178/067002A003017800523109309:user/release-keys

# ProductModel=Pdx237 cho Dolby. FP stock user/release-keys ver 17: app nhan A17,
# tranh lo userdebug. Build tags: vendor/evolution-priv/keys via evolution.mk keys.mk
PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="XQ-DE72-user 17 67.2.A.3.178 067002A003017800523109309 release-keys" \
    BuildFingerprint=Sony/XQ-DE72/XQ-DE72:17/67.2.A.3.178/067002A003017800523109309:user/release-keys \
    ProductModel=Pdx237
