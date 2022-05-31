# Copyright (C) 2021 Kidd Chen <kidd-kw.chen@mediatek.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Mediatek Neuropilot packages"

inherit packagegroup
inherit features_check
REQUIRED_DISTRO_FEATURES = "nda-mtk"

COMPATIBLE_MACHINE = "i1200-demo"

PACKAGES = " \
	${PN} \
"

RDEPENDS:${PN} = " \
	apusys \
	apusys-firmwares \
	neuropilot-bin \
	libstdc++ \
	python3-pillow \
"