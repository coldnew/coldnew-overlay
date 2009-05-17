# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

DESCRIPTION="F-IRC is an IRC client for terminals"
HOMEPAGE="http://www.vanheusden.com/fi/"
SRC_URI="http://www.vanheusden.com/fi/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-debug-fix.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -DVERSION='\"Gentoo-${PVR}\"'" DEBUG="" || die "emake failed"
}

src_install() {
	dobin fi || die "dobin failed"
	dodoc Changes firc.* readme.txt || die "dodoc failed"
}
