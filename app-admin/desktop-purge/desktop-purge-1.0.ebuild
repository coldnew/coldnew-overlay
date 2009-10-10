# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION=""
HOMEPAGE=""
#SRC_URI="http://pcman.sayya.org/desktop-purge.c"
SRC_URI="mirror://sourceforge/coldnew-overlay/desktop-purge-${PVR}.tar.lzma"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 x86 amd64"
IUSE=""
DEPEND=""
RDEPEND=${DEPEND}
MAKEOPTS="-j1"
FEATURES="-sandbox -usersandbox" 

#S=${WORKDIR}/${MY_P}

src_unpack() {
		unpack ${A}
	    cd "${S}"
}

src_compile() {
	emake || die
}

src_install() {
	cd "${S}"
	make INSTALL_ROOT="${D}" install || die
#	make DESTDIR="${D}" install || die
}

