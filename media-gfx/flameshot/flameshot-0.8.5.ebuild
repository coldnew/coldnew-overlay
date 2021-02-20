# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake qmake-utils toolchain-funcs xdg-utils

DESCRIPTION="Powerful yet simple to use screenshot software for GNU/Linux"
HOMEPAGE="https://flameshot.org"
SRC_URI="https://github.com/flameshot-org/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="FreeArt GPL-3+ Apache-2.0"
SLOT="0"
IUSE="kde"

DEPEND="
	>=dev-qt/qtsvg-5.9.0:5
	>=dev-qt/qtcore-5.9.0:5
	>=dev-qt/qtdbus-5.9.0:5
	>=dev-qt/qtnetwork-5.9.0:5
	>=dev-qt/qtwidgets-5.9.0:5
	>=dev-qt/linguist-tools-5.9.0:5
	>=dev-util/cmake-3.13
"
RDEPEND="${DEPEND}
	kde? (
		kde-plasma/plasma-desktop:5
		kde-frameworks/kglobalaccel:5
	)
"

src_prepare(){
	cmake_src_prepare
#	sed -i "s#icons#pixmaps#" ${PN}.pro
#	sed -i "s#^Icon=.*#Icon=${PN}#" "docs/desktopEntry/package/${PN}.desktop"
#	default_src_prepare
}

src_configure(){
	if tc-is-gcc && ver_test "$(gcc-version)" -lt 7.4.0 ;then
		die "You need at least GCC 7.4 to build this package"
	fi
	# eqmake5 CONFIG+=packaging
	cmake_src_configure
}

# src_install(){
	# INSTALL_ROOT="${D}" default_src_install
	# if use kde; then
		# insinto /usr/share/config
		# newins docs/shortcuts-config/${PN}-shortcuts-kde ${PN}rc
	# fi
# }

pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}
