FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

DEMO_CFG = " \
	file://usb-audio.cfg \
"

SRC_URI_append = ' \
	${@bb.utils.contains("DISTRO_FEATURES", "demo", "${DEMO_CFG}", "", d)} \
'
