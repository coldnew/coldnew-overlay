# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

DESCRIPTION="Compressed ROM filesystem for Linux (user-space)"
HOMEPAGE="http://bisqwit.iki.fi/source/cromfs.html"
SRC_URI="http://bisqwit.iki.fi/src/arch/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-strip-and-upx.patch
}

src_compile() {
	emake \
		OPTIM="${CFLAGS}" \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		CPP="$(tc-getCPP)" \
		|| die "emake failed"
}

src_install() {
	use static && dobin cromfs-driver-static || dobin cromfs-driver
	dobin util/{cvcromfs,mkcromfs,unmkcromfs}
}
