# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils autotools

DESCRIPTION="portable lightweight userspace bandwidth shaper"
HOMEPAGE="http://monkey.org/~marius/pages/?page=trickle"
SRC_URI="http://monkey.org/~marius/trickle/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libevent"

src_prepare() {
	epatch "${FILESDIR}/${P}-libobjs.diff"
	epatch "${FILESDIR}/${P}-overloadDATA.diff"
	epatch "${FILESDIR}/${P}-automake-cflags.diff"
	epatch "${FILESDIR}/${P}-in_addr_t.diff"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}
