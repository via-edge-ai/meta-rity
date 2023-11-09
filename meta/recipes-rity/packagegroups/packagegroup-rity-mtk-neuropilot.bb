# Copyright (C) 2021 Kidd Chen <kidd-kw.chen@mediatek.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Mediatek Neuropilot packages"

inherit packagegroup
inherit features_check

COMPATIBLE_MACHINE = "(mt8395|mt8390|mt8370)"

PACKAGES = " \
	${PN} \
"

RDEPENDS:${PN} = " \
	apusys \
	apusys-firmwares \
	neuropilot-bin \
"
