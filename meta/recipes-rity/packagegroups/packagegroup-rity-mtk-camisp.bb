# Copyright (C) 2022 Andy Hsieh <andy.hsieh@mediatek.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Mediatek Camera ISP Packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
"

RDEPENDS:${PN} = " \
	mtk-vcu-driver-mt8395 \
	mtk-camisp-driver \
	mtk-camisp-prebuilts \
"
