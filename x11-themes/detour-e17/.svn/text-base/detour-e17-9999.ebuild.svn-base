# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="http://detour.googlecode.com/svn/branches/${PN#detour-}"

inherit subversion

DESCRIPTION="Enlightenment DR17 ${PN} theme"
HOMEPAGE="http://code.google.com/p/detour/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-wm/enlightenment
	media-libs/edje"
RDEPEND="${DEPEND}"

src_compile() {  	
	make build || die "make install failed"
}

src_install() {
	insinto /usr/share/enlightenment/data/themes/
	doins ${PN}.edj 
}
