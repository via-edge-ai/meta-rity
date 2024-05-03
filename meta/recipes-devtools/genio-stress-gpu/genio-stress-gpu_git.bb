LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=0162574e7503bb231524b8203915d2c6"

SRC_URI = "${AIOT_RITY_URI}/genio-stress-gpu;protocol=https;branch=main"
SRCREV = "b0b90942ae8531d2da1cc98305fea6c059a7f001"

S = "${WORKDIR}/git"
PV = "git${SRCPV}"

# opencl-icd-loader: for linking to libOpenCL.so
# opencl-headers: for OpenCL header files (CL/OpenCL.h)
DEPENDS = "opencl-icd-loader opencl-headers"

# libOpenCL.so should be responsible for searching and loading
# the actual libmali.so installed in Genio EVK.
RDEPENDS:${PN} += " opencl-icd-loader"

do_compile () {
	# Build the default target
	oe_runmake
}

do_install () {
	# The Makefile does not define a target named "install",
	# so assign install path here.
	install -d -m 0755 ${D}${bindir}
	install -m 0755 ${B}/genio-stress-gpu ${D}${bindir}
}

FILES:${PN} = "${bindir}/genio-stress-gpu"
