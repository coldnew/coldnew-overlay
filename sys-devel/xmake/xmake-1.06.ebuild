# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Portable [X]Make utility"
HOMEPAGE="http://apollo.backplane.com/xmake/"
SRC_URI="http://apollo.backplane.com/${PN}/${P}.tgz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S="${WORKDIR}"/${PN}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin xmake || die "dobin failed"
	doman xmake.1
	dodoc README RELEASE_NOTES
}
