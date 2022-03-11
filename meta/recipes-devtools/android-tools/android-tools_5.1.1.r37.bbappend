FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
    file://core/0014-add-u3-ss-descriptor-support-for-adb.patch;patchdir=system/core \
"
