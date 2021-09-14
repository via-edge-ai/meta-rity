FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI:append = " \
	file://wpa_supplicant-wlan0.conf \
"

do_install:append() {
	install -d ${D}${sysconfdir}/wpa_supplicant
	install -m 0644 ${WORKDIR}/wpa_supplicant-wlan0.conf ${D}${sysconfdir}/wpa_supplicant/

	# Enable the wpa_supplicant@wlan0.service, uncomment these 2 following lines
	#install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
	#ln -sf ${systemd_unitdir}/system/wpa_supplicant@.service \
	#	${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service
}

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${PN}', '', d)}"
SYSTEMD_SERVICE:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'wpa_supplicant@wlan0.service', '', d)}"

FILES:${PN} += " \
	/lib \
	/lib/systemd \
	/lib/systemd/system \
	/lib/systemd/system/* \
	${sysconfdir}/wpa_supplicant/* \
"
