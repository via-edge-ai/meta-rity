# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

require recipes-bsp/images/rity-bsp-image.bb

DESCRIPTION = "Rity Demo Image"

IMAGE_INSTALL += "\
	packagegroup-rity-demo-qt \
	packagegroup-rity-ai-ml \
	rity-demo-opencl \
	python3-pip \
	python3-opencv \
	opkg \
	benchmark-suite \
	ltp \
"

IMAGE_INSTALL:remove:i300b = " \
	packagegroup-rity-demo-qt \
"

IMAGE_INSTALL:append:i350 = " \
	packagegroup-rity-nnapi \
"

IMAGE_INSTALL:append:i500 = " \
	packagegroup-rity-nnapi \
"

IMAGE_INSTALL:append:i1200 = " \
	packagegroup-rity-tsn \
"
