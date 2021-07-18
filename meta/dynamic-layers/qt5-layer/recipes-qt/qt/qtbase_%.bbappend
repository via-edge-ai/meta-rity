RDEPENDS_${PN} += "fontconfig"

PACKAGECONFIG_append = " \
	${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'gles2', '', d)} \
	fontconfig \
"

# Qt5
QT_CONFIG_FLAGS += " \
	${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '-qpa wayland', '', d)} \
"
# Qt6
QT_QPA_DEFAULT_PLATFORM = " \
	${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wayland', '', d)} \
"
