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

IMAGE_INSTALL:append:som-5000 = " \
	packagegroup-rity-tsn \
	r2inference \
	gstinference \
"

#
# Packages added by VIA
#
IMAGE_INSTALL:append:som-5000 = " \
	usb-mount \
	lte-apn \
	quectelcm \
	init-quectel-cm \
	libqmi \
	lte-qmi-conf \
	mmc-mount \
	mcu-utils \
	start-wdt \
	mcu-rtc \
	stress-scripts \
	libhailort \
	hailortcli \
	libgsthailo \
	hailo-pci \
	hailo-firmware \
	python3-pybind11 \
	neuronruntimehelper \
	modelmark \
	via-version \
	vthermal \
	vplay \
	vmediaplayer \
	vtool \
	vcenter \
	vsettings \
	vcamera \
	key-handler \
"

# VIA Edge AI (LenZ).
IMAGE_INSTALL:append:som-5000 = " \
	lighttpd \
	libwebsockets \
	jsoncpp \
	paho-mqtt-c \
	curl \
	libxml2 \
	gst-lenz-plugin \
"

