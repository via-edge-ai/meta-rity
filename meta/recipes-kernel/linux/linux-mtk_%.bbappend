FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append=  " \
	file://usbnet.cfg \
	${@bb.utils.contains('DISTRO_FEATURES', 'nfs', 'file://nfs.cfg', '', d)} \
"
