DESCRIPTION = "The recipe is used for collecting board assets and generating \
a tarball, which is used for flashing individual partition."
LICENSE = "MIT"

inherit deploy

ASSETS_DIR = "${WORKDIR}/board-assets"

collect_artifacts() {
	cp ${DEPLOY_DIR_IMAGE}/bl2.img ${ASSETS_DIR}
	cp ${DEPLOY_DIR_IMAGE}/fip.bin ${ASSETS_DIR}
	cp ${DEPLOY_DIR_IMAGE}/u-boot-initial-env ${ASSETS_DIR}
	cp ${DEPLOY_DIR_IMAGE}/lk.bin ${ASSETS_DIR}
	cp ${DEPLOY_DIR_IMAGE}/firmware.vfat ${ASSETS_DIR}
	cp ${DEPLOY_DIR_IMAGE}/bootassets.vfat ${ASSETS_DIR}
}

do_deploy() {
	mkdir -p ${ASSETS_DIR}

	collect_artifacts

	cd ${WORKDIR}
	tar zcf ${DEPLOYDIR}/board-assets.tar.gz `basename ${ASSETS_DIR}`
}

do_deploy[depends] += " \
    virtual/lk:do_deploy \
    virtual/bl2:do_deploy \
    virtual/bootloader:do_deploy \
    trusted-firmware-a:do_deploy \
    firmware-part:do_deploy \
    bootassets-part:do_deploy \
"
addtask do_deploy after do_compile
