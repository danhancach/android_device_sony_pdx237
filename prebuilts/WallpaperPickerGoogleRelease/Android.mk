#
# SPDX-License-Identifier: Apache-2.0
#
# Pre-mustang WallpaperPickerGoogle — tranh crash Theme.AppCompat cua blob mustang.
# Override PRODUCT_PACKAGES WallpaperPickerGoogleRelease tu vendor/gms.
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := WallpaperPickerGoogleReleasePdx237
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := WallpaperPickerGoogleRelease.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_CLASS := APPS
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_PRIVILEGED_MODULE := true
LOCAL_OVERRIDES_PACKAGES := WallpaperPickerGoogleRelease
LOCAL_OPTIONAL_USES_LIBRARIES := androidx.window.extensions androidx.window.sidecar org.apache.http.legacy
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
include $(BUILD_PREBUILT)
