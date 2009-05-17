# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="IDE for C and assembly for MCUs based on 8051"
HOMEPAGE="http://mcu8051ide.sourceforge.net"
SRC_URI="http://prdownloads.sourceforge.net/mcu8051ide/${PF}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86"

IUSE="noterminal no_c"
RDEPEND="
	!noterminal? ( >=x11-terms/rxvt-unicode-8.3 )
	!no_c? (
		>=dev-embedded/sdcc-2.5
		>=app-doc/doxygen-1.5
		>=dev-util/indent-2.2
	)
"
DEPEND="
	${RDEPEND}
	>=dev-util/cmake-2.4.3
	>=dev-tcltk/bwidget-1.8
	>=dev-tcltk/itcl-3.3
	>=dev-lang/tcl-8.4.18
	>=dev-tcltk/tdom-0.8
	>=dev-tcltk/tcllib-1.6.1
	>=dev-lang/tk-8.4.18
	>=dev-tcltk/tkimg-1.3
"

src_unpack() {
	unpack ${A}
}

src_compile() {
	cd "${PF}"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd "${PF}"
	emake DESTDIR="${D}" install || die "Install failed"
}

pkg_postinst() {
	einfo
	einfo "Type mcu8051ide to run MCU 8051 IDE"
	einfo "	or mcu8051ide --help for more options"
	einfo "You can report any problems or sugestions at http://mcu8051ide.sf.net"
	einfo
}
