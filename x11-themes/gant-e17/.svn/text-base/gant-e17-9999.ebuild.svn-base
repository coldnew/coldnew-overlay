# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="http://gant-e17.googlecode.com/svn/trunk/"
ESVN_FETCH_CMD="svn checkout"

inherit subversion

DESCRIPTION="Enlightenment DR17 ${PN} theme"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-wm/enlightenment
	media-libs/edje
"
RDEPEND=""

src_compile() {  	
edje_cc $@ -id . -fd . gant-e17.edc -o gant-e17.edj
#make build || die "make install failed"
}

src_install() {
insinto /usr/share/enlightenment/data/themes/
doins ${PN}.edj 
}
