#
# SPDX-License-Identifier: Apache-2.0
#

#
# pdx237: Mini GApps.
# - Messages (PrebuiltBugle) + Phone (GoogleDialer) tu gms_mini
# - Chrome van loai bang RemovePackages
# - WallpaperPickerGoogleRelease: blob mustang crash Theme.AppCompat →
#   dung prebuilts/WallpaperPickerGoogleRelease (Pdx237 override)
#

include vendor/gms/gms_mini.mk

PRODUCT_PACKAGES += \
    WallpaperPickerGoogleReleasePdx237 \
    Photos
