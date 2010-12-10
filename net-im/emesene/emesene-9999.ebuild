# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Ebuild Modifiqued By DJ_DEXTER, this Ebuild is not Official!
# $Header: $
	
inherit subversion eutils python
	
DESCRIPTION="A MSN Messenger Clone for UNIX written in Python"
HOMEPAGE="www.emesene.org"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""
	
ESVN_REPO_URI="https://emesene.svn.sourceforge.net/svnroot/emesene/trunk/emesene"
ESVN_PROJECT="emesene"
	
DEPEND=">=dev-lang/python-2.4.3
>=x11-libs/gtk+-2.10.14
>=dev-python/pygtk-2.12.1-r2"
	
src_install() {
dodir /usr/share/emesene
insinto /usr/share/emesene
doins -r ./*
exeinto /usr/share/emesene
doexe emesene
dosym /usr/share/emesene/emesene /usr/bin/emesene
#Make_desktop_entry ${PN} "emesene" "/usr/share/emesene/themes/default/#icon.png" 

}
pkg_postinst() {
python_mod_optimize /usr/share/emesene
ewarn "This is a live ebuild"
ewarn "That means there are NO promises it will work."
}

pkg_postrm() {
python_mod_cleanup /usr/share/emesene
}
