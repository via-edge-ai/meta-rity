FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
FILESEXTRAPATHS:prepend:genio-700-evk := "${THISDIR}/files/genio-700-evk:"
FILESEXTRAPATHS:prepend:genio-1200-evk := "${THISDIR}/files/genio-1200-evk:"

inherit systemd

SRC_URI:append = " \
	file://udhcpd.conf \
	file://usb.network \
	file://usbgadget.sh \
	file://usbgadget.service \
	file://eth.network \
	file://wireless.network \
"

SRC_URI:append:genio-700-evk = " \
	file://usbgadget.conf \
	file://usbhub.sh \
	file://usbhub.service \
	file://wwan-5g.sh \
	file://wwan-5g.service \
"

SRC_URI:append:genio-1200-evk = " \
	file://usbgadget.conf \
	file://usbmass.sh \
	file://usbmass.service \
"

# Create symlink to /lib if multilib support is disabled
python () {
    d.setVar('SYMLIB64', '0')
    if not d.getVar('MULTILIBS', True):
        d.setVar('SYMLIB64', '1')
}

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

	if [ "${SYMLIB64}" = "1" ]; then
		ln -sf lib/ ${D}/lib64
	fi
}

do_install:append:genio-700-evk() {
	# Define default USB gadget port (ADB)
	install -m 0644 ${WORKDIR}/usbgadget.conf ${D}${sysconfdir}/usbgadget.conf

	# Create folder for services enabled by default
	install -d ${D}/${sysconfdir}/systemd/system/multi-user.target.wants/

	# USB Hub service
	install -m 0644 ${WORKDIR}/usbhub.service ${D}${systemd_unitdir}/system/
	install -m 0755 ${WORKDIR}/usbhub.sh ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/usbhub.sh ${D}${systemd_unitdir}
	ln -sfr ${D}/${systemd_system_unitdir}/usbhub.service ${D}/${sysconfdir}/systemd/system/multi-user.target.wants/usbhub.service

	# WWAN 5G Card service
	install -m 0644 ${WORKDIR}/wwan-5g.service ${D}${systemd_unitdir}/system/
	install -m 0755 ${WORKDIR}/wwan-5g.sh ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/wwan-5g.sh ${D}${systemd_unitdir}
	# User should enable it manually or they sure it can be enabled by default.
	# ln -sfr ${D}/${systemd_system_unitdir}/wwan-5g.service ${D}/${sysconfdir}/systemd/system/multi-user.target.wants/wwan-5g.service
}

do_install:append:genio-1200-evk() {
	# Define default USB gadget port (ADB)
	install -m 0644 ${WORKDIR}/usbgadget.conf ${D}${sysconfdir}/usbgadget.conf

	# Create folder for services enabled by default
	install -d ${D}/${sysconfdir}/systemd/system/multi-user.target.wants/

	# USB Mass Storage service
	install -m 0644 ${WORKDIR}/usbmass.service ${D}${systemd_unitdir}/system/
	install -m 0755 ${WORKDIR}/usbmass.sh ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/usbmass.sh ${D}${systemd_unitdir}
	ln -sfr ${D}/${systemd_system_unitdir}/usbmass.service ${D}/${sysconfdir}/systemd/system/multi-user.target.wants/usbmass.service

	# WWAN 5G Card service
	install -m 0644 ${WORKDIR}/wwan-5g.service ${D}${systemd_unitdir}/system/
	install -m 0755 ${WORKDIR}/wwan-5g.sh ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/wwan-5g.sh ${D}${systemd_unitdir}
	# User should enable it manually or they sure it can be enabled by default.
	# ln -sfr ${D}/${systemd_system_unitdir}/wwan-5g.service ${D}/${sysconfdir}/systemd/system/multi-user.target.wants/wwan-5g.service
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
FILES:${PN}:append:genio-700-evk = " \
	${sysconfdir}/usbgadget.conf \
	${systemd_unitdir}/system/usbhub.service \
	${sysconfdir}/systemd/system/multi-user.target.wants/usbhub.service \
	${systemd_unitdir}/system/wwan-5g.service \
"
FILES:${PN}:append:genio-1200-evk = " \
	${sysconfdir}/usbgadget.conf \
	${systemd_unitdir}/system/usbmass.service \
	${sysconfdir}/systemd/system/multi-user.target.wants/usbmass.service \
	${systemd_unitdir}/system/wwan-5g.service \
"

# WWAN 5G Card service section:
#   User should enable it manually or they sure it can be enabled by default.

# genio-700-evk
# FILES:${PN}:append:genio-700-evk += " \
# 	${sysconfdir}/systemd/system/multi-user.target.wants/wwan-5g.service \
# "
#
# genio-i1200-evk
# FILES:${PN}:append:genio-1200-evk += " \
# 	${sysconfdir}/systemd/system/multi-user.target.wants/wwan-5g.service \
# "
