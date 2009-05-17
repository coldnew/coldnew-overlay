# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="An IRC bot coded in C++"
HOMEPAGE="http://home.darksun.com.pt/mbot/"
SRC_URI="http://home.darksun.com.pt/mbot/sources/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 tcl xml"

DEPEND="tcl? ( dev-lang/tcl )
	xml? ( dev-libs/libxml )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_compile() {
	econf \
		$(use_enable ipv6) \
		$(use_enable tcl) \
		$(use_enable xml) \
		|| die "econf failed"
	# debug means no stripping is performed
	emake debug || die "emake failed"
}

src_install() {
	dobin mbot || die "dobin failed"

	exeinto /usr/lib/mbot
	doexe mod/*.so || die "doexe failed"

	docinto examples
	dodoc example/example.* || die "dodoc failed"

	docinto sripts
	dodoc scripts/*.tcl || die "dodoc failed"
}
