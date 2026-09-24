#
# Copyright (C) 2018 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

-include device/sony/sm8550-common/BoardConfigCommon.mk

DEVICE_PATH := device/sony/pdx237

# Audio
AUDIO_FEATURE_ENABLED_LSM_HIDL := false

# Sony stock libbundlewrapper (360RA) shares install path with AOSP libbundlewrapper.
BUILD_BROKEN_DUP_RULES := true
# A17 blocks ELF in PRODUCT_COPY_FILES; 360RA Sony blobs still use COPY_FILES + dup rules.
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Display
TARGET_SCREEN_DENSITY := 420

# Kernel
TARGET_KERNEL_CONFIG += vendor/sony/pdx237.config
DO_NOT_REBUILD_KERNEL := true
# Ép không kbuild lại nếu đã có Image. Xóa Image để build kernel mới:
#   rm -f out/target/product/pdx237/obj/KERNEL_OBJ/arch/arm64/boot/Image
FORCE_SKIP_KERNEL_BUILD := true

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# OTA
TARGET_OTA_ASSERT_DEVICE := pdx237,XQ-DE72

# Vendor
-include vendor/sony/pdx237/BoardConfigVendor.mk
