# Copyright (C) 2021 Julien Stephan <jstephan@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity AI-ML packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
"

RDEPENDS:${PN} = " \
	tensorflow-lite \
	armnn \
	onnxruntime-staticdev \
	onnxruntime-examples \
	onnxruntime \
"
