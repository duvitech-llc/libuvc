######################################################################
# libuvc_static.a (static library with static link to libjpeg, libusb1.0)
######################################################################
LOCAL_PATH	:= $(call my-dir)

LIBUSB_ROOT_REL:= ../..
LIBUSB_ROOT_ABS:= $(LOCAL_PATH)/../..

include $(CLEAR_VARS)

LOCAL_C_INCLUDES += \
	$(LIBUSB_ROOT_ABS)/ \
	$(LIBUSB_ROOT_ABS)/include \
	$(LIBUSB_ROOT_ABS)/android/include \
	$(LIBUSB_ROOT_ABS)/include/libuvc

LOCAL_EXPORT_C_INCLUDES := \
	$(LIBUSB_ROOT_ABS)/ \
	$(LIBUSB_ROOT_ABS)/include \
	$(LIBUSB_ROOT_ABS)/android/include \
	$(LIBUSB_ROOT_ABS)/include/libuvc

LOCAL_CFLAGS := $(LOCAL_C_INCLUDES:%=-I%)
LOCAL_CFLAGS += -DANDROID_NDK
LOCAL_CFLAGS += -DLOG_NDEBUG
LOCAL_CFLAGS += -DUVC_DEBUGGING

LOCAL_EXPORT_LDLIBS := -llog

LOCAL_ARM_MODE := arm

LOCAL_SHARED_LIBRARIES += jpeg-turbo
LOCAL_SHARED_LIBRARIES += libusb

LOCAL_SRC_FILES := \
	$(LIBUSB_ROOT_ABS)/src/ctrl.c \
	$(LIBUSB_ROOT_ABS)/src/device.c \
	$(LIBUSB_ROOT_ABS)/src/diag.c \
	$(LIBUSB_ROOT_ABS)/src/frame.c \
	$(LIBUSB_ROOT_ABS)/src/frame-mjpeg.c \
	$(LIBUSB_ROOT_ABS)/src/init.c \
	$(LIBUSB_ROOT_ABS)/src/stream.c

LOCAL_MODULE := libuvc_static
include $(BUILD_STATIC_LIBRARY)

######################################################################
# libuvc.so
######################################################################
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_EXPORT_LDLIBS += -llog

LOCAL_WHOLE_STATIC_LIBRARIES = libuvc_static
LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

LOCAL_MODULE := libuvc
include $(BUILD_SHARED_LIBRARY)