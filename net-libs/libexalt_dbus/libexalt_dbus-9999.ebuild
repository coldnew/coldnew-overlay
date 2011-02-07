# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI=svn://svn.berlios.de/exalt/trunk/${PN}

inherit subversion

DESCRIPTION="libexalt interface to dbus"
HOMEPAGE="http://watchwolf.fr/wiki/doku.php?id=exalt&DokuWiki=55e526b8a5538c9ee450e4d3954ac23f"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
	x11-libs/ecore
	x11-libs/e_dbus
	net-libs/libexalt
"
RDEPEND=""

src_compile() {
	./autogen.sh || die "autogen.sh failed"
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
