# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="http://detour.googlecode.com/svn/branches/${PN#detour-}"
ESVN_FETCH_CMD="svn checkout"

inherit subversion

DESCRIPTION="Enlightenment DR17 ${PN} theme"
HOMEPAGE="http://code.google.com/p/detour/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-wm/enlightenment
	media-libs/edje
	x11-libs/ewl
"
RDEPEND=""

src_compile() {  	
make build || die "make install failed"
}

src_install() {
insinto /usr/share/ewl/themes/
doins ${PN}.edj 
}
