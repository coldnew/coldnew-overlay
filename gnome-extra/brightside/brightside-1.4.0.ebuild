# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

GCONF_DEBUG="no"
WANT_AUTOMAKE="1.7"
WANT_AUTOCONF="none"

inherit gnome2 eutils autotools

DESCRIPTION="Screen Corners and Edges daemon"
HOMEPAGE="http://wiki.catmur.co.uk/Brightside/"
SRC_URI="http://files.catmur.co.uk/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=x11-libs/libwnck-2.2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"

pkg_setup() {
	G2CONF="--enable-tray-icon"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-wnck.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch

	eautomake
}
