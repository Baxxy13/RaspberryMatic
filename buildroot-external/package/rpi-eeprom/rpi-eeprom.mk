################################################################################
#
# rpi-eeprom
#
################################################################################

RPI_EEPROM_VERSION = 551d9da1847bf2d79a6943c8ec0f8d11f907c499
RPI_EEPROM_SITE = $(call github,raspberrypi,rpi-eeprom,$(RPI_EEPROM_VERSION))
RPI_EEPROM_LICENSE = BSD-3-Clause
RPI_EEPROM_LICENSE_FILES = LICENSE
RPI_EEPROM_INSTALL_IMAGES = YES
RPI_EEPROM_FIRMWARE_PATH = firmware/stable/pieeprom-2022-11-04.bin

define RPI_EEPROM_BUILD_CMDS
	$(@D)/rpi-eeprom-config $(@D)/$(RPI_EEPROM_FIRMWARE_PATH) --out $(@D)/default.conf
	(cat $(@D)/default.conf | grep -v ^$$; echo HDMI_DELAY=0) > $(@D)/boot.conf
	$(@D)/rpi-eeprom-config $(@D)/$(RPI_EEPROM_FIRMWARE_PATH) --config $(@D)/boot.conf --out $(@D)/pieeprom.upd
	sha256sum $(@D)/pieeprom.upd | awk '{ print $$1 }' > $(@D)/pieeprom.sig
	echo "ts: $$(date -u +%s)" >> $(@D)/pieeprom.sig
endef

define RPI_EEPROM_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/pieeprom.sig $(BINARIES_DIR)/rpi-eeprom/pieeprom.sig
	$(INSTALL) -D -m 0644 $(@D)/pieeprom.upd $(BINARIES_DIR)/rpi-eeprom/pieeprom.upd
endef

$(eval $(generic-package))
