# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="Command line filter that displays the data bandwidth and total number of bytes passing through a pipe"
HOMEPAGE="http://zakalwe.virtuaalipalvelin.net/~shd/foss/pmr/"
SRC_URI="http://zakalwe.virtuaalipalvelin.net/~shd/foss/${PN}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin pmr || die "dobin failed"
	doman pmr.1 || die "doman failed"
	dodoc ChangeLog || die "dodoc failed"
}
