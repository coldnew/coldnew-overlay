# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Libsylph for sylph email"
RESTRICT=nomirror
HOMEPAGE="http://sylpheed.sraoss.jp/"
SRC_URI="http://sylpheed.sraoss.jp/sylpheed/${PN}/${PN}-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""

src_compile() {
econf || die "Configuration failed"	
emake || die "emake failed"
}

src_install() {
make DESTDIR="${D}" install || die "Install Failed"	
}


