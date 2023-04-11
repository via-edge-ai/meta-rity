FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DEPENDS += "bc-native dtc-native u-boot-tools-native"

SRC_URI += " \
	file://boot.script \
	${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://secure-boot.cfg", "", d)} \
	file://fdt-env.cfg \
	file://0001-cmd-Add-new-command-to-source-embedded-script.patch \
	file://boot.script.its \
	${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://secure-cap.dts", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://u-boot-cap.key", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://u-boot-cap.crt", "", d)} \
	${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://u-boot-cap", "", d)} \
"


do_uboot_env() {
        boot_conf=`echo "#conf-${KERNEL_DEVICETREE}" | tr '/' '_'`
        fastboot_entry="setenv fastboot_entry 0"
        storage="mmc"
        storage_dev="0"

        if [ "${@bb.utils.contains('MACHINE_FEATURES', 'ufs-boot', 'ufs-boot', '', d)}" = "ufs-boot" ]; then
                storage="scsi"
                storage_dev="2"
        fi

        for dtbo in ${KERNEL_DEVICETREE_OVERLAYS_AUTOLOAD};
        do
                boot_conf="$boot_conf#conf-$dtbo"
        done

        if [ "${1}" = "u-boot.dtb" ]; then
                dtc -I dtb -O dts -o ${B}/u-boot-mtk-config.dts ${B}/${UBOOT_DTB_BINARY}
cat >> ${B}/u-boot-mtk-config.dts <<- EOC
/ {
        config {
                environment {
                        check_fastboot_entry = "$fastboot_entry";
                        fdt_boot_conf = "$boot_conf";
                        storage = "$storage";
                        storage_dev = "$storage_dev";
                        boot_scripts = "fitImage";
                };
        };
};
EOC
                dtc -I dts -O dtb -o ${B}/${UBOOT_DTB_BINARY} ${B}/u-boot-mtk-config.dts

        if [ "${@bb.utils.contains("DISTRO_FEATURES", "fwupdate", "1", "0", d)}" = "1" ]; then
                dtc -I dts -O dtb -o ${B}/secure-cap.dtbo ${WORKDIR}/secure-cap.dts
                fdtoverlay -i ${B}/${UBOOT_DTB_BINARY} -o ${B}/${UBOOT_DTB_BINARY} -v ${B}/secure-cap.dtbo
        fi

        fi

	if [ "${1}" = "u-boot-initial-env" ]; then
	        echo check_fastboot_entry=$fastboot_entry >> ${DEPLOYDIR}/u-boot-initial-env
	        echo boot_conf=$boot_conf >> ${DEPLOYDIR}/u-boot-initial-env
	        echo storage=$storage >> ${DEPLOYDIR}/u-boot-initial-env
	        echo storage_dev=$storage_dev >> ${DEPLOYDIR}/u-boot-initial-env
	        echo "boot_scripts=fitImage" >> ${DEPLOYDIR}/u-boot-initial-env
	        echo boot_targets=embedded >> ${DEPLOYDIR}/u-boot-initial-env
	fi
}

do_install:append() {
	# Append boot script binary to the end of u-boot binary
	cd ${WORKDIR}
	${UBOOT_MKIMAGE} -f ${WORKDIR}/boot.script.its ${WORKDIR}/boot.script.bin
	cat ${B}/${UBOOT_BINARY} ${WORKDIR}/boot.script.bin > ${D}/boot/${UBOOT_IMAGE}
}

do_deploy:append() {
	if [ ${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "1", "0", d)} = "0" ]; then
		do_uboot_env "u-boot-initial-env"
	fi

	if [ ${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "1", "0", d)} = "1" ]; then
		cp ${WORKDIR}/u-boot-cap.* ${DEPLOYDIR}
	fi

	# Sometimes the boot.script.bin might not exist since artifacts of do_install
	# have been cached and won't be regenerated. In this case, we need to check
	# existence and regenerate it if necessary.
	if [ ! -e "${WORKDIR}/boot.script.bin" ]; then
		cd ${WORKDIR}
		${UBOOT_MKIMAGE} -f ${WORKDIR}/boot.script.its ${WORKDIR}/boot.script.bin
	fi
	# Append boot script binary to the end of u-boot binary
	cat ${B}/${UBOOT_BINARY} ${WORKDIR}/boot.script.bin > ${DEPLOYDIR}/${UBOOT_IMAGE}
}

do_add_env_to_dtb() {
	if [ ${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "1", "0", d)} = "1" ]; then
		do_uboot_env "u-boot.dtb"
	fi
}

addtask add_env_to_dtb before do_install after do_compile

do_deploy:append:i300-pumpkin() {
	sed -i '/^check_fastboot_entry=.*/c\check_fastboot_entry=gpio input 42; if test $? -eq 0; then setenv fastboot_entry 1; else setenv fastboot_entry 0; fi' ${DEPLOYDIR}/u-boot-initial-env
}

inherit deploy

SYSROOT_DIRS += " /boot"
