LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# pixman-android-neon.S uses gcc-specific directive.
LOCAL_CLANG_ASFLAGS_arm += -no-integrated-as

LOCAL_SDK_VERSION := 14

LOCAL_MODULE := libpixman

LOCAL_CFLAGS := -DHAVE_CONFIG_H -fvisibility=hidden

LOCAL_C_INCLUDES := $(LOCAL_PATH)/android

# Core files
LOCAL_SRC_FILES := \
	pixman-matrix.c

# Android additions
LOCAL_SRC_FILES += \
	pixman-android.c

ifeq ($(strip $(TARGET_ARCH)),arm)
	# Will only be used if runtime detection reports NEON capabilities
	LOCAL_CFLAGS += -DUSE_ARM_NEON
	LOCAL_SRC_FILES += \
		pixman-android-neon.S
endif

LOCAL_STATIC_LIBRARIES := cpufeatures

include $(BUILD_STATIC_LIBRARY)

$(call import-module,android/cpufeatures)
