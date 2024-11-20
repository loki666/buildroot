################################################################################
#
# mali-driver
#
################################################################################

MALI_DRIVER_VERSION = r51p0-00eac0
MALI_DRIVER_SOURCE = BX304L01B-SW-99002-${MALI_DRIVER_VERSION}.tar
MALI_DRIVER_SITE = https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-bifrost-gpu
MALI_DRIVER_DEPENDENCIES = linux

define MALI_DRIVER_BUILD_CMDS
	$(MAKE) ARCH=${KERNEL_ARCH} KDIR=${LINUX_DIR} -C $(@D)/product/kernel/drivers/gpu/arm/midgard \
		$(TARGET_CONFIGURE_OPTS) \
		CONFIG_MALI_MIDGARD=m \
		CONFIG_MALI_PLATFORM_NAME=sunxi \
		CONFIG_MALI_REAL_HW=y \
		CONFIG_MALI_DEVFREQ=y \
		CONFIG_MALI_GATOR_SUPPORT=n \
		CONFIG_ARCH_SUN50IW9=y \
		all
endef

define MALI_DRIVER_INSTALL_TARGET_CMDS
	cp $(@D)/product/kernel/drivers/gpu/arm/midgard/mali_kbase.ko \
		$(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)
endef

$(eval $(generic-package))
