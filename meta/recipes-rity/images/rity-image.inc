# Copyright (C) 2020 Fabien Parent <fparent@baylibre.com>
# Released under the MIT license (see COPYING.MIT for the terms)

inherit core-image
inherit image-buildinfo

IMAGE_INSTALL:append = " mtk-vpud"
IMAGE_INSTALL:append:i1200 = " mtk-vcodec-mt8395 mtk-vcu-mt8395"

my_postprocess_rootfs() {
	if ${@bb.utils.contains('DISTRO_FEATURES','wayland','true','false',d)}; then
		echo "mkdir -p /run/user/\$(id -u)" >> ${IMAGE_ROOTFS}/etc/profile
		echo "chmod 0700 /run/user/\$(id -u)" >> ${IMAGE_ROOTFS}/etc/profile
		echo "export XDG_RUNTIME_DIR=/run/user/\$(id -u)" >> ${IMAGE_ROOTFS}/etc/profile
	fi
}

ROOTFS_POSTPROCESS_COMMAND += "my_postprocess_rootfs; "
