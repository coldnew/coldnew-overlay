# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Set of programs to inspect and build Windows Installer (.MSI) files"
HOMEPAGE="https://wiki.gnome.org/msitools"
LICENSE="LGPL-2+"

SLOT="0"
SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

KEYWORDS="~amd64 ~arm ~arm64"

IUSE="+introspection"
REQUIRED_USE="
	introspection
"

RDEPEND=(
	"dev-libs/glib:2"
	"sys-apps/util-linux[libuuid]"
	"dev-libs/libxml2"
	"gnome-extra/libgsf[introspection]"
	"$(vala_depend)"
	"app-arch/gcab[vala]"
)
DEPEND_A="$RDEPEND"


src_prepare() {
	sed -i "s/^  version: run_command.*$/version: '${PV}',/" meson.build
	vala_src_prepare
	default
}


src_configure() {
	local emeasonargs=(
		$(meson_use introspection)
	)

	meson_src_configure
}
