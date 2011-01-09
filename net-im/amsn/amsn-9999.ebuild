# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

ESVN_REPO_URI="https://amsn.svn.sourceforge.net/svnroot/amsn/trunk/amsn"
ESVN_PROJECT="amsn"
inherit subversion eutils

DESCRIPTION="Alvaro's Messenger client for MSN"
HOMEPAGE="http://amsn.sourceforge.net"

IUSE="debug nolibng static gnome kde skins plugins xft"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~sparc x86"


DEPEND=">=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4
	>=dev-tcltk/tls-1.4.1
	xft? (
		>=dev-lang/tcl-8.5 
		>=dev-lang/tk-8.5 )
	skins? ( =net-im/amsn-extras-9999 )
	plugins? ( =net-im/amsn-extras-9999 )"

RDEPEND="${DEPEND}"


pkg_setup() {
   eerror "This is a LIVE SVN ebuild."
   eerror "That means there are NO promises it will work."
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable nolibng) \
		$(use_enable static) \
		$(use_enable xft) \
		|| die "configure failed"

	emake || die

}

src_install() {

	make DESTDIR="${D}" install || die
	dodoc AGREEMENT TODO README FAQ CREDITS

	domenu amsn.desktop
	sed -i -e s:.png:: "${D}/usr/share/applications/amsn.desktop"

	cd desktop-icons
	for i in *; do
		if [ -e ${i}/msn.png ]; then
			insinto /usr/share/icons/hicolor/${i}/apps
			doins  ${i}/msn.png
		fi
	done


	if use gnome
	then
		dodir /usr/share/applications
		cp /usr/share/amsn_cvs/amsn.desktop /usr/share/applications
		einfo "Installing GNOME/KDE Icons in /usr/share/pixmaps"
		dodir /usr/share/pixmaps
		cp -a ${S}/icons/32x32/* ${D}/usr/share/pixmaps/
	fi
	
	if use kde
	then
		dodir /usr/share/applnk/Internet
		cp /usr/share/amsn_cvs/amsn.desktop /usr/share/applnk/Internet/
		einfo "Installing KDE Icons in default theme"
		dodir /usr/share/pixmaps
		cp -a ${S}/icons/32x32/* ${D}/usr/share/pixmaps/
	fi
}

pkg_postinst() {
   ewarn "You might have to remove ~/.amsn prior to running as user if amsn hangs on start-up."
   ewarn "Remember, this stuff is SVN only code so dont cry when"
   ewarn "I break you :)."
   ewarn "If you want to report bugs, go to our forum at http://amsn.sf.net/forums"
   ewarn "or use our IRC channel at irc.freenode.net #amsn"
   ewarn ""
}
