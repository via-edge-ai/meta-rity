require conf/distro/poky.conf

DISTRO = "rity"
DISTRO_NAME = "Rity"
DISTRO_VERSION = "22.2-dev"

WKS_FILE = "rity.wks.in"
IMAGE_HOME_SIZE = "200M"

# Boot configuration tweaks
KERNEL_CLASSES = "kernel-fitimage-mtk"
UBOOT_ENV_SUFFIX = "script"
UBOOT_ENV = "boot"
include conf/machine/include/rity-${MACHINE}.inc
