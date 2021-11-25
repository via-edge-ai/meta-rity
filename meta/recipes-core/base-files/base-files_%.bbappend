FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI:append = " \
	file://udhcpd.conf \
	file://usb.network \
	file://usbgadget.sh \
	file://usbgadget.service \
	file://eth.network \
	file://wireless.network \
"

do_install:append() {
	install -d ${D}${systemd_unitdir}/system
	install -d ${D}${sysconfdir}/init.d

	install -d ${D}${sysconfdir}/systemd/network/
	install -m 0644 ${WORKDIR}/usb.network ${D}${sysconfdir}/systemd/network/
	install -m 0644 ${WORKDIR}/eth.network ${D}${sysconfdir}/systemd/network/
	install -m 0644 ${WORKDIR}/wireless.network ${D}${sysconfdir}/systemd/network/

	install -m 0644 ${WORKDIR}/usbgadget.service ${D}${systemd_unitdir}/system/
	install -m 0755 ${WORKDIR}/usbgadget.sh ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/usbgadget.sh ${D}${systemd_unitdir}

	install -m 0644 ${WORKDIR}/udhcpd.conf ${D}${sysconfdir}/udhcpd.conf
}

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${PN}', '', d)}"
SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'usbgadget.service', '', d)}"
FILES:${PN} += " \
	${systemd_unitdir}/usbgadget.sh \
	${systemd_unitdir}/system/usbgadget.service \
	${sysconfdir}/systemd/system/multi-user.target.wants/usbgadget.service \
	${sysconfdir}/systemd/network/usb.network \
	${sysconfdir}/systemd/network/eth.network \
	${sysconfdir}/systemd/network/wireless.network \
	${sysconfdir}/udhcpd.conf \
"
