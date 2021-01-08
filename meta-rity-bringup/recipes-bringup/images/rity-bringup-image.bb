# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "Rity Bringup Image"

IMAGE_FEATURES += "ssh-server-dropbear"

IMAGE_INSTALL += "\
	packagegroup-base \
	packagegroup-core-boot \
	packagegroup-core-full-cmdline \
	packagegroup-rity-audio \
	packagegroup-rity-debug \
	packagegroup-rity-display \
	packagegroup-rity-multimedia \
	packagegroup-rity-optee \
	packagegroup-rity-tools \
	packagegroup-rity-zeroconf \
"

IMAGE_INSTALL_remove_i300b = " \
	packagegroup-display \
	packagegroup-multimedia \
"

require recipes-rity/images/rity-image.inc
