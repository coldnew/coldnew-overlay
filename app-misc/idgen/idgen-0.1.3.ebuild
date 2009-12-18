# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

inherit eutils cmake-utils

DESCRIPTION="An ID Generator for Taiwanese."
HOMEPAGE="http://idgenerator.sourceforge.net"
SRC_URI="mirror://sourceforge/idgenerator/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2.4
	>=x11-libs/pango-1.4
	 "
RDEPEND="${DEPEND}
         dev-util/cmake
		" 

MAKEOPTS="-j1"


src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	mycmakeargs="${mycmakeargs}"

	cmake-utils_src_compile

#econf || die "configure failed"
#	emake || die
}

src_install() {
	cmake-utils_src_install

	#cd "${S}"
	#make DESTDIR="${D}" install || die

	dodoc README
}

