# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="Enlightenment hardware browser written in ETK based on libdetect"
HOMEPAGE="http://www.hylius.fr"

ESVN_REPO_URI="svn://svn.tuxfamily.org/svnroot/hylius/${PN}/trunk"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/etk
	=sys-libs/detect-0.9.91
	dev-db/edb"
RDEPEND="${DEPEND}"


src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
