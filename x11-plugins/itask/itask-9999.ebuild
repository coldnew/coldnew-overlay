# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

DESCRIPTION="e17 ${PN#e_modules-} module"
SLOT="0"

ESVN_REPO_URI="http://itask-module.googlecode.com/svn/trunk/itask"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

DEPEND=">=media-libs/edje-0.5.0
	>=x11-wm/enlightenment-0.16.999"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
