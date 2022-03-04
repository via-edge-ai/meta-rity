# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "Rity Demo Image"

IMAGE_FEATURES += "ssh-server-dropbear"

IMAGE_INSTALL += "\
	packagegroup-base-extended \
	packagegroup-core-base-utils \
	packagegroup-core-boot \
	packagegroup-core-full-cmdline \
	packagegroup-rity-audio-extended \
	packagegroup-rity-debug-extended \
	packagegroup-rity-devel-extended \
	packagegroup-rity-display-extended \
	packagegroup-rity-multimedia-extended \
	packagegroup-rity-net-extended \
	packagegroup-rity-optee-extended \
	packagegroup-rity-tools-extended \
	packagegroup-rity-zeroconf-extended \
	packagegroup-rity-demo-qt \
	packagegroup-rity-ai-ml \
	packagegroup-tools-bluetooth \
	gstreamer1.0-meta-base \
	gstreamer1.0-meta-audio \
	gstreamer1.0-meta-debug \
	gstreamer1.0-meta-video \
	gstreamer1.0-python \
	rity-demo-opencl \
	python3-pip \
	python3-opencv \
	opkg \
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

require recipes-rity/images/rity-image.inc
