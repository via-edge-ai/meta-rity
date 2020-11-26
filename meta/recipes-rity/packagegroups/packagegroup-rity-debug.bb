# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity Debug packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
	${PN}-extended \
"

RDEPENDS_${PN} = " \
	gdb \
	i2c-tools \
	i2c-tools-misc \
	libgpiod-tools \
	strace \
	stress-ng \
	powertop \
"

RDEPENDS_${PN}-extended = " \
	${PN} \
"
