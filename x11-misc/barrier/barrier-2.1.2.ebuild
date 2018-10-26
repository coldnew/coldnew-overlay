# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils cmake-utils

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers"
HOMEPAGE="http://synergy-project.org/ https://github.com/symless/synergy-core"
SRC_URI="
	https://github.com/debauchee/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="libressl qt5"

S=${WORKDIR}/${PN}-${PV}

COMMON_DEPEND="
	net-misc/curl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXtst
	net-dns/avahi
	!libressl? ( dev-libs/openssl:* )
	libressl? ( dev-libs/libressl )
	qt5? (
	     dev-qt/qtcore:5
	     dev-qt/qtgui:5
	     dev-qt/qtdeclarative:5
	     net-dns/avahi[mdnsresponder-compat]
	)
"
DEPEND="
	${COMMON_DEPEND}
	x11-base/xorg-proto
"
RDEPEND="
	${COMMON_DEPEND}
"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	append-cxxflags ${mycmakeargs}
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install () {
	dobin ../${P}_build/bin/${PN}{c,s} ../${P}_build/bin/barrier
	dobin ../${P}_build/bin/${PN}{c,s} ../${P}_build/bin/barrierc
	dobin ../${P}_build/bin/${PN}{c,s} ../${P}_build/bin/barriers
}

#pkg_preinst() {
#	use qt5 && gnome2_icon_savelist
#}
#
#pkg_postinst() {
#	use qt5 && gnome2_icon_cache_update
#}
#
#pkg_postrm() {
#	use qt5 && gnome2_icon_cache_update
#}
