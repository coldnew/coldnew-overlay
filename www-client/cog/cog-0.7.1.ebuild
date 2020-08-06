# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=7

inherit cmake-utils

DESCRIPTION=" WPE launcher and webapp container "
HOMEPAGE="https://github.com/Igalia/cog"
SRC_URI="https://github.com/Igalia/cog/releases/download/v${PV}/${PN}-${PV}.tar.xz -> ${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="webkitgtk"

DEPEND="
	>=gui-libs/libwpe-1.4.0.1
	>=gui-libs/wpebackend-fdo-1.4.0
	net-libs/wpewebkit
	>=dev-libs/glib-2.40
        webkitgtk? ( net-libs/webkit-gtk )
"
RDEPEND="${DEPEND}"

src_configure() {
  local mycmakeargs=(
      -DCOG_USE_WEBKITGTK="$(usex webkitgtk)"
  )
  cmake-utils_src_configure
}
