# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Onyx is a powerful stack-based, multi-threaded, interpreted, general purpose programming language"
HOMEPAGE="http://www.canonware.com/onyx/"
SRC_URI="http://www.canonware.com/download/${PN}/${P}.tar.bz2"

LICENSE="onyx"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug pcre"

RDEPEND="pcre? ( >=dev-libs/libpcre-4.2 )"
DEPEND="${RDEPEND}
	>=dev-util/cook-2.20"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-as-needed.patch
}

src_compile() {
	econf \
		$(use_enable pcre regex) \
		$(use_enable debug) \
		|| die "econf failed"
	cook || die "cook failed"
}

src_install() {
	cook install PREFIX="${D}"/usr MANDIR="${D}"/usr/share/man || die "cook install failed"

	dodoc COPYING ChangeLog INSTALL PLATFORMS README
	dohtml doc/html/onyx/*
}
