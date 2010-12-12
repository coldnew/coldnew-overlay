
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

#ESVN_REPO_URI="https://emesene.svn.sourceforge.net/svnroot/emesene/trunk/mesinyer"
#ESVN_PROJECT="emesene2"

inherit eutils git

EGIT_REPO_URI="https://github.com/emesene/emesene.git"

DESCRIPTION="Platform independent MSN Messenger client written in Python+GTK"
HOMEPAGE="http://www.emesene.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"


DEPEND="
	>=dev-lang/python-2.4.3
	>=x11-libs/gtk+-2.8.20
	>=dev-python/pygtk-2.8.6
	"

RDEPEND="${DEPEND}"


pkg_setup() {

	ewarn "This is a LIVE GIT ebuild."
	ewarn "That means there are NO promises it will work."

}

src_install() {

	cd ${S}/emesene/
	dodir /usr/share/emesene2
	insinto /usr/share/emesene2
	doins -r ./*
	dodir /usr/bin
	exeinto /usr/bin
	echo -e '#!/bin/sh \n cd /usr/share/emesene2/ \n python emesene.py'>> emesene2-start
	doexe emesene2-start

        newicon ${S}/themes/default/logo.png ${PN}.png
        make_desktop_entry emesene2-start "EmeSeNe 2 (mesinyer)" ${PN}.png

}

pkg_postinst() {
	ewarn "Remember, this stuff is SVN only code so dont cry when"
	ewarn "I break you :)."
	ewarn "If you want to report bugs, go to our forum at http://emesene.org/forums"
} 
