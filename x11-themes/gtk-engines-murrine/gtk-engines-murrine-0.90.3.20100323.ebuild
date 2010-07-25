# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils gnome.org

MY_PN="gtk2-engines-murrine"
MY_PV="0.90.3+git20100323"
DESCRIPTION="Murrine GTK+2 Cairo Engine"

HOMEPAGE="http://www.cimitan.com/murrine/"
SRC_URI="mirror://ubuntu/pool/main/g/${MY_PN}/${MY_PN}_${MY_PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="+themes animation-rtl"

RDEPEND=">=x11-libs/gtk+-2.12"
PDEPEND="themes? ( x11-themes/murrine-themes )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.37.1
	sys-devel/gettext
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}-${MY_PV}"
RESTRICT="primaryuri"

src_prepare() {
	epatch "${FILESDIR}"/01_display_only_selected_menu_items.patch
}

src_configure() {
	econf --enable-animation \
		--enable-rgba \
		$(use_enable animation-rtl animationrtl)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog TODO
}
