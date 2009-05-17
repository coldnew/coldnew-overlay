# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="MadEdit is an Open-Source and Cross-Platform Text/Hex Editor written in C++ and wxWidgets."
HOMEPAGE="http://madedit.sourceforge.net/wiki/index.php/Main_Page"
SRC_URI="mirror://sourceforge/madedit/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 x86 amd64"
IUSE=""
DEPEND="
		>=dev-libs/boost-1.33.0
		>=x11-libs/wxGTK-2.6.1
	   "
RDEPEND=${DEPEND}
MAKEOPTS="-j1"

S=${WORKDIR}/${P/_/.}

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	./configure --prefix=/usr
	emake || die
}

src_install() {
	cd "${S}"
	make DESTDIR="${D}" install || die
}

