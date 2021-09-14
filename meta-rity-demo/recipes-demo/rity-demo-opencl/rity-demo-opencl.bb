LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DESCRIPTION = "Rity-demo-opencl"

SRC_URI = " \
	file://demo-opencl.py \
"

RDEPENDS:${PN} = " \
	opencv \
	python3 \
	python3-opencv \
"

do_install() {
	install -d -m 0755 ${D}/home/root/
	install -d -m 0755 ${D}/home/root/demos/
	install -m 0744 ${WORKDIR}/demo-opencl.py ${D}/home/root/demos/
}

FILES:${PN} = "/home/root/demos/*"
