# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="A CD burner based on EWL and Libburn."
HOMEPAGE="http://code.google.com/p/ecdb"

ESVN_REPO_URI="http://ecdb.googlecode.com/svn/trunk/ecdb"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libburn
	dev-libs/libisofs
	x11-libs/ewl"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
}
