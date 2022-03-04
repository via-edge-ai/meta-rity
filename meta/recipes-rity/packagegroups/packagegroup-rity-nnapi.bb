# Copyright (C) 2021 Julien Stephan <jstephan@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity NNAPI package"

inherit packagegroup

COMPATIBLE_MACHINE = "(i500-*|i350-*)"

PACKAGES = " \
	${PN} \
"

RDEPENDS:${PN} = " \
	nnapi \
"
