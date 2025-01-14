FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DEMO_CFG = " \
	file://usb-audio.cfg \
	file://exfat.cfg \
"

SRC_URI:append = ' \
	${@bb.utils.contains("DISTRO_FEATURES", "demo", "${DEMO_CFG}", "", d)} \
'
