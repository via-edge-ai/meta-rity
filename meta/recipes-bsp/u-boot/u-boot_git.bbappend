FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DEPENDS += "bc-native dtc-native u-boot-tools-native"

SRC_URI += " \
	file://boot.script \
	${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "file://secure-boot.cfg", "", d)} \
	file://fdt-env.cfg \
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
        fi

	if [ "${1}" = "u-boot-initial-env" ]; then
	        echo check_fastboot_entry=$fastboot_entry >> ${DEPLOYDIR}/u-boot-initial-env
	        echo boot_conf=$boot_conf >> ${DEPLOYDIR}/u-boot-initial-env
	        echo storage=$storage >> ${DEPLOYDIR}/u-boot-initial-env
	        echo storage_dev=$storage_dev >> ${DEPLOYDIR}/u-boot-initial-env
	        echo "boot_scripts=fitImage" >> ${DEPLOYDIR}/u-boot-initial-env
	fi
}

do_deploy:append() {
	if [ ${@bb.utils.contains("DISTRO_FEATURES", "secure-boot", "1", "0", d)} = "0" ]; then
		do_uboot_env "u-boot-initial-env"
	fi
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
