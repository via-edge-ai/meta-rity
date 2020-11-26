# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Rity Multimedia packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
	${PN}-extended \
"

RDEPENDS_${PN} = " \
	gstreamer1.0 \
	gstreamer1.0-plugins-base \
	gstreamer1.0-plugins-good \
	gstreamer1.0-plugins-bad \
	libcamera \
	libcamera-gst \
	v4l-utils \
	yavta \
"

RDEPENDS_${PN}-extended = " \
	${PN} \
	ffmpeg \
	mpg123 \
	x264 \
"
