# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils flag-o-matic wxwidgets

MY_P=${PN/m/M}-${PV}
S="${WORKDIR}"/${MY_P}-src

DESCRIPTION="iMule, eMule inside i2p network client"
HOMEPAGE="http://www.imule.i2p"
SRC_URI="${MY_P}-src.tbz"
RESTRICT="fetch mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug nls unicode"

RDEPEND="net-p2p/i2p"
DEPEND="=x11-libs/wxGTK-2.8*
	>=dev-libs/crypto++-5.5.2
	>=sys-libs/zlib-1.2.1
	unicode? ( >=media-libs/gd-2.0.26 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/noxas.bz2"
}

src_configure() {
	local myconf

	WX_GTK_VER="2.8"
	need-wxwidgets unicode
	econf \
		--with-wx-config=${WX_CONFIG} \
		--disable-ed2k \
		$(use_enable debug) \
		$(use_enable !debug optimize) \
		$(use_enable nls) \
		${myconf} || die
}

src_install() {
	emake DESTDIR="${D}" install-exec || die
}
