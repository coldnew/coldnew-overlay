# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="http://itask-module.googlecode.com/svn/trunk/itask-ng"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

DESCRIPTION="${PN} plugin for e17"
HOMEPAGE="http://code.google.com/p/itask-module"
SLOT="0"
IUSE=""

DEPEND=">=x11-wm/enlightenment-0.16.999.039
	media-libs/edje
	dev-libs/efreet"


src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
