#
# KT VoLTE (MCC/MNC 450-08) for imported Xperia with Korea SIM.
# EFS pack source: SONY VOLTE XPERIA-KT (beta8).
#

VOLTE_KT_EFS_SRC := $(LOCAL_PATH)/../sm8550-common/volte-efs/kt
VOLTE_KT_EFS_FILES := $(shell find $(VOLTE_KT_EFS_SRC) -type f 2>/dev/null | sort)

PRODUCT_COPY_FILES += \
    $(foreach f,$(VOLTE_KT_EFS_FILES),\
        $(f):$(TARGET_COPY_OUT_VENDOR)/etc/volte-efs/kt/$(patsubst $(VOLTE_KT_EFS_SRC)/%,%,$(f)))

PRODUCT_PACKAGES += \
    efs_kt_loader \
    init.volte-kt.rc
