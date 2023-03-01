require conf/distro/poky.conf

DISTRO = "rity"
DISTRO_NAME = "Rity"
DISTRO_VERSION = "23.0-ea-release"

WKS_FILE = "rity.wks.in"
IMAGE_HOME_SIZE = "200M"

# Boot configuration tweaks
KERNEL_CLASSES = "kernel-fitimage-mtk kernel-mod-image"
UBOOT_ENV_SUFFIX = "script"
UBOOT_ENV = "boot"
include conf/machine/include/rity-${MACHINE}.inc
