# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Another Traditional Chinese IM."
HOMEPAGE="http://www.csie.nctu.edu.tw/~cp76/gcin/ http://cle.linux.org.tw/trac/wiki/GcinGirlForNoBopomofo"
SRC_URI="http://cle.linux.org.tw/gcin/download/${P/_/.}.tar.bz2
	chinese-sound? ( http://cle.linux.org.tw/gcin/download/ogg.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ia64 ~ppc ~hppa"
IUSE="immqt immqt-bc filter-nobopomofo chinese-sound anthy"
DEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2.4
	>=dev-libs/atk-1.0.1
	>=x11-libs/pango-1.4
	immqt? ( =x11-libs/qt-3* )
	immqt-bc? ( =x11-libs/qt-3* )
	 >=app-i18n/anthy-9100
	 "
#    "amd64? ( app-emulation/emul-linux-x86-gtklibs )"
RDEPEND=${DEPEND}
MAKEOPTS="-j1"

S=${WORKDIR}/${P/_/.}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# apply gcc34 patch
	#epatch ${FILESDIR}/gcin-1.0.9-gcc344.patch
	# apply qt im-module patch
	#
	if use=immqt || immqt-bc; then
	epatch "${FILESDIR}/gcin-1.4.4-qt3_fix.patch"
	epatch "${FILESDIR}/gcin-1.4.4-qt4_fix.patch"
	fi
}

src_compile() {
	econf \
	        $(use_enable anthy) \
	        $(use_enable immqt) \
	        $(use_enable immat-bc) \
	        $(use_enable debug) \
	        $(use_enable filter-nobopomofo) \
	        $(use_enable chinese-sound) \
	|| die "configure failed"

	emake || die
}

src_install() {
	cd "${S}"
	make DESTDIR="${D}" install || die

	if use xim-select
	then
		insinto "/etc/xim-select/"
		doins "${FILESDIR}/extras/gcin"
	fi

	dodoc README

	if use filter-nobopomofo
	then
		insinto /usr/share/pixmaps/gcin
		doins "${FILESDIR}/nobopomofo/SS1135_ST.jpg"
		doins "${FILESDIR}/nobopomofo/SS1208_DT.jpg"
		exeinto /usr/share/gcin/script/
		doexe "${FILESDIR}/nobopomofo/gcin-filter-nobopomofo"
		insinto /etc/env.d
		doins "${FILESDIR}/nobopomofo/99gcin-filter-nobopomofo"
	fi

	if use chinese-sound
	then
		mkdir "${D}/usr/share/gcin"
		mv "${WORKDIR}/ogg ${D}/usr/share/gcin"
	fi
}

