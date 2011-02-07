# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI=http://e-mail.googlecode.com/svn/trunk/

inherit subversion

DESCRIPTION="ETK-based email client for Enlightenment."
HOMEPAGE="http://code.google.com/p/e-mail"
SRC_URI=""

LICENSE="New BSD License"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libsylph"
RDEPEND=""

src_compile() {
#### Still in alpha stages #####
#  ./autogen.sh || die "autogen.sh failed"
#  econf || die "econf failed"
#  emake || die "make failed"
make
}

src_install() {
#### Still in alpha stages #####
#	einstall || die "install failed"

dobin E-Mail || die "Install Failed"
}
