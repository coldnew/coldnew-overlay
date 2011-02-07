# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_SERVER="http://itask-module.googlecode.com/svn/trunk"
inherit enlightenment subversion

DESCRIPTION="${PN} plugin for e17"
HOMEPAGE="http://code.google.com/p/itask-module"

DEPEND=">=x11-wm/enlightenment-0.16.999.039
	media-libs/edje
	dev-libs/efreet"
