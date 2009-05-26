# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://pcman.sayya.org/desktop-purge.c"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 x86 amd64"
IUSE=""
DEPEND="
	   "
RDEPEND=${DEPEND}
MAKEOPTS="-j1"

S=${WORKDIR}/desktop-purge.c

src_unpack() {
	cp /var/tmp/portage/app-admin/desktop-purge-0.1/distdir/* ${S} 

}

src_compile() {
	#econf
	gcc `pkg-config glib-2.0 --cflags --libs` -o desktop-purge desktop-purge.c
	emake || die
}

src_install() {
	cd "${S}"
	make DESTDIR="${D}" install || die
}

