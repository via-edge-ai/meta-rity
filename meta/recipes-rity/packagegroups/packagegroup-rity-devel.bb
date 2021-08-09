# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity Development packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
	${PN}-extended \
"

RDEPENDS_${PN} = " \
	curl \
	gdb \
	ldd \
	rsync \
	strace \
	valgrind \
	opencl-icd-loader-dev \
	clinfo \
"

RDEPENDS_${PN}-extended = " \
	${PN} \
"
