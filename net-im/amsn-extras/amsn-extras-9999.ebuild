# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

ESVN_REPO_URI="https://amsn.svn.sourceforge.net/svnroot/amsn/trunk/amsn-extras"
ESVN_PROJECT="amsn"
inherit subversion eutils

DESCRIPTION="Alvaro's Messenger client for MSN"
HOMEPAGE="http://amsn.sourceforge.net"

IUSE="skins plugins"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~sparc x86"


RDEPEND=">=net-im/amsn-0.97"

#RDEPEND="${DEPEND}"


pkg_setup() {
   eerror "This is a LIVE SVN ebuild."
   eerror "That means there are NO promises it will work."
}


src_install() {
	if use skins
	then
		einfo "Installing skins"
		dodir /usr/share/amsn/skins
		cp -r ${S}/skins/* ${D}/usr/share/amsn/skins/
	fi

	if use plugins
	then
		einfo "Installing plugins"
		dodir /usr/share/amsn/plugins
		cp -r ${S}/plugins/* ${D}/usr/share/amsn/plugins/
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
