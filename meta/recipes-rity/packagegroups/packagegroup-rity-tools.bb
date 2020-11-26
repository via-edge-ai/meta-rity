# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity Tools packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
	${PN}-extended \
"

RDEPENDS_${PN} = " \
	htop \
	ldd \
	pm-utils \
	rng-tools \
	usbutils \
	u-boot-fw-utils \
	watchdog \
	wireless-regdb-static \
"

RDEPENDS_${PN}-extended = " \
	${PN} \
	lsof \
	sed \
	zip \
"
