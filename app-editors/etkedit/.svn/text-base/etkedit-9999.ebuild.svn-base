# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="Simple editor written in Etk"
HOMEPAGE="http://code.google.com/p/etkedit/"

ESVN_REPO_URI="http://etkedit.googlecode.com/svn/trunk"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/etk"
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
}
