# Copyright (C) 2022 Macross Chen <macross.chen@mediatek.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Mediatek Video Packages"

inherit packagegroup

PACKAGES = " \
	${PN} \
"

RDEPENDS:${PN}:mt8365 = " \
	mtk-vcu-driver \
	mtk-vcodec-driver \
	mtk-mdp-driver \
"

RDEPENDS:${PN}:mt8195 = " \
	mtk-vcu-driver \
	mtk-vcodec-driver \
"