# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-1.8.6-r1.ebuild,v 1.7 2009/03/27 17:03:18 armin76 Exp $

inherit eutils flag-o-matic libtool git

EGIT_REPO_URI="git://github.com/Dieterbe/uzbl.git"

DESCRIPTION="…a keyboard controlled (modal vim-like bindings, or with modifierkeys) browser based on Webkit."
HOMEPAGE="http://www.uzbl.org"
SRC_URI=""

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RESTRICT="test"

RDEPEND="=net-libs/webkit-gtk-0_p42162[soup]
      net-libs/libsoup
      x11-libs/gtk+"

DEPEND="${RDEPEND}
   >=dev-util/pkgconfig-0.19
   "

src_unpack() {
   git_src_unpack
   cd "${S}"

}

src_compile() {

   emake || die "compile failed"
}

src_install() {
   emake -j1 DESTDIR="${D}" install || die "Installation failed"
   dodoc AUTHORS ChangeLog NEWS README
}
