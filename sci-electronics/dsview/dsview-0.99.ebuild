# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# http://distortos.org/documentation/building-kconfig-frontends-linux/
EAPI="6"

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit eutils python-single-r1 cmake-utils gnome2-utils xdg-utils

SRC_URI="https://github.com/DreamSourceLab/DSView/archive/${PV}.tar.gz -> DSView-${PV}.tar.gz"
KEYWORDS="~x86 ~amd64"

DESCRIPTION="Qt based logic analyzer GUI for dslogic"
HOMEPAGE="https://www.dreamsourcelab.com/"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="
       dev-qt/qtcore:5
       dev-qt/qtgui:5
       dev-qt/qtwidgets:5
       dev-libs/libusb:1
       dev-libs/libzip
       >=sci-libs/libsigrok4DSL-${PV}:=
       >=sci-libs/libsigrokdecode4DSL-${PV}:=[${PYTHON_USEDEP}]
       ${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
        virtual/pkgconfig"

S=${WORKDIR}/DSView-${PV}/DSView

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}