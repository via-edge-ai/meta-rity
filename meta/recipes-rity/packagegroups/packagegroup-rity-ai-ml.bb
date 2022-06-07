# Copyright (C) 2021 Julien Stephan <jstephan@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity AI-ML packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
	${PN}-extended \
"

RDEPENDS:${PN} = " \
	tensorflow-lite \
	armnn \
"

RDEPENDS:${PN}-extended = " \
	${PN} \
	onnxruntime-staticdev \
	onnxruntime-examples \
	onnxruntime \
"
