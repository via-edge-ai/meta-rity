# WARNING: please update the rity docs if you modify this file

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_i500-skeleton =  " \
	file://0001-arm64-dts-mediatek-add-MT8183-skeleton-dts.patch \
	file://skeleton.cfg \
"
