# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity OP-TEE packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
	${PN}-extended \
"

RDEPENDS_${PN} = " \
	optee-client \
	optee-examples \
	optee-test \
"

RDEPENDS_${PN}-extended = " \
	${PN} \
"
