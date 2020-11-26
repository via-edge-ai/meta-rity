# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "Rity Demo Image"

IMAGE_FEATURES += "ssh-server-dropbear"

IMAGE_INSTALL = "\
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
	packagegroup-tools-bluetooth \
	gstreamer1.0-meta-base \
	gstreamer1.0-meta-audio \
	gstreamer1.0-meta-debug \
	gstreamer1.0-meta-video \
	gstreamer1.0-python \
"

require recipes-rity/images/rity-image.inc
