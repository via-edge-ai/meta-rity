# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity Audio packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
	${PN}-extended \
"

RDEPENDS:${PN} = " \
	alsa-state \
	alsa-utils \
"

PULSEAUDIO_PKGS = " \
	pulseaudio \
	pulseaudio-module-bluez5-device \
	pulseaudio-module-bluez5-discover \
	pulseaudio-module-bluetooth-policy \
	pulseaudio-server \
	pulseaudio-module-alsa-card \
	pulseaudio-misc \
"


RDEPENDS:${PN}-extended = " \
	${PN} \
	${@bb.utils.contains("DISTRO_FEATURES", "pulseaudio", "${PULSEAUDIO_PKGS}", "", d)} \
"
