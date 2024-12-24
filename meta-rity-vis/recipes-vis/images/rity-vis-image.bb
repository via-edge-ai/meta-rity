# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

require recipes-rity/images/rity-image.inc

DESCRIPTION = "VIA Intelligent Solutions Image"

IMAGE_INSTALL += "\
	packagegroup-rity-ai-ml \
	ite-it6510-driver \
	lontium-lt6911-driver \
"

IMAGE_INSTALL:append:genio-700 = " \
	packagegroup-rity-mtk-video \
	packagegroup-rity-mtk-neuropilot \
	packagegroup-rity-mtk-camisp \
"
