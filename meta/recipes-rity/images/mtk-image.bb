# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "MediaTek image with some development tools (Obsolete)"

IMAGE_FEATURES += "ssh-server-dropbear"

WAYLAND_PACKAGES = " \
	wayland \
	weston \
	weston-init \
"

IMAGE_INSTALL += "\
	packagegroup-base \
	packagegroup-core-boot \
	packagegroup-core-full-cmdline \
	packagegroup-rity-audio \
	packagegroup-rity-zeroconf \
	${@bb.utils.contains("DISTRO_FEATURES", "optee", "optee-client", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "wayland", "${WAYLAND_PACKAGES}", "", d)} \
"

require rity-image.inc
