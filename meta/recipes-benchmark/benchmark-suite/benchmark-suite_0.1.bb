SUMMARY = "Benchmark suite for AIOT Yocto platforms"
HOMEPAGE = "https://gitlab.com/mediatek/aiot/bsp/benchmark_suite"
SECTION = "benchmark/tests"
LICENSE = "GPL-2.0-only & GPL-2.0-or-later & GPL-3.0-or-later & Apache-2.0"
LIC_FILES_CHKSUM = "file://COPYING;md5=941d6d45d5f146ffe07fe4d50168f754"

inherit base

SRC_URI = " \
    ${AIOT_BSP_URI}/benchmark_suite;branch=main \
    file://COPYING \
    file://skip-tests.patch \
"
SRCREV = "a56726b5f489b3889976f118c48417008be28de8"

S = "${WORKDIR}/git"

TARGET_CC_ARCH += "${LDFLAGS}"

do_copy_license () {
    cp ${WORKDIR}/COPYING ${S}
}

do_configure () {
    PLAT="${SOC_FAMILY}"
    NUM_CORES=4
    if [ "$PLAT" = "mt8195" ]; then
        NUM_CORES=8
    fi

    echo "export NUM_CORES=$NUM_CORES" >> ${S}/common
}

do_compile () {
    export CROSS_COMPILE="${TARGET_ARCH}-poky-linux-"
    ./build.sh
}

do_install () {
    install -d ${D}${ROOT_HOME}/benchmark_suite
    cp -r ${S}/_build/benchmark_${TARGET_ARCH}/* ${D}${ROOT_HOME}/benchmark_suite
}

DEPENDS = " \
    unzip-native \
    cmake-native \
"

RDEPENDS:${PN} = " \
    bash \
    perf \
"

FILES:${PN} = "${ROOT_HOME}/benchmark_suite"

addtask do_copy_license after do_unpack before do_populate_lic
