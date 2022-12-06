FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append=  " \
	file://usbnet.cfg \
	file://pm.cfg \
	${@bb.utils.contains('DISTRO_FEATURES', 'nfs', 'file://nfs.cfg', '', d)} \
	${@bb.utils.contains('DISTRO_FEATURES', 'ubsan', 'file://ubsan.cfg', '', d)} \
"
