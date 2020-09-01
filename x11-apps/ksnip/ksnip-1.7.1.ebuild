# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="A Qt based screenshot tool"
HOMEPAGE="https://github.com/DamirPorobic/ksnip"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DamirPorobic/ksnip"
else
	SRC_URI="https://github.com/DamirPorobic/ksnip/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5[png]
	dev-qt/qtxml:5
	dev-qt/qtx11extras:5
	kde-frameworks/extra-cmake-modules:5
	x11-libs/kcolorpicker
	>=x11-libs/kimageannotator-0.3.1
	x11-libs/libxcb"

DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/linguist-tools
	virtual/pkgconfig"

src_prepare() {
	cmake_src_prepare
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
