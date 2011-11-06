# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Enlightenment Hardware Browser"
HOMEPAGE="http://www.hylius.fr/"
SRC_URI="ftp://download.tuxfamily.org/hylius/${P}.tar.bz2" 
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/etk
	=sys-libs/detect-0.9.91
	dev-db/edb"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make \
		DESTDIR="${D}" \
		install || die
}