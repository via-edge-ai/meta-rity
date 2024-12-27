# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

require recipes-bsp/images/rity-bsp-image.bb

DESCRIPTION = "VIA Intelligent Solutions Image"

IMAGE_INSTALL += "\
	packagegroup-rity-demo-qt \
	packagegroup-rity-ai-ml \
	packagegroup-rity-graphics \
	rity-demo-opencl \
	python3-pip \
	python3-opencv \
	opkg \
	benchmark-suite \
	ltp \
"

IMAGE_INSTALL:append:vab-5000 = " \
	packagegroup-rity-tsn \
	r2inference \
	gstinference \
"

#
# Packages added by VIA
#
IMAGE_INSTALL:append:vab-5000 = " \
	usb-mount \
	lte-apn \
	quectelcm \
	init-quectel-cm \
	libqmi \
	lte-qmi-conf \
	libmbim \
	lte-mbim-conf \
	mmc-mount \
	mcu-utils \
	start-wdt \
	mcu-rtc \
	stress-scripts \
	python3-pybind11 \
	neuronruntimehelper \
	modelmark \
	via-version \
	vplay \
	vmediaplayer \
	vtool \
	vcenter \
	vsettings \
	vcamera \
"
