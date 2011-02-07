# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git autotools base

DESCRIPTION="Compiz for E17 hack"
HOMEPAGE="http://code.google.com/p/itask-module/wiki/Stuff"

EGIT_REPO_URI="git://github.com/jeffdameth/ecomorph.git"
EGIT_BOOTSTRAP="eautoreconf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="fuse svg"

RDEPEND="=x11-wm/enlightenment-9999*
	=x11-wm/ecomp-9999"	
DEPEND="${RDEPEND}"
