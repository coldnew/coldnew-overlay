# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod subversion

ESVN_REPO_URI="https://svn.baycom.de/repos/dvbloop/"

DESCRIPTION="A virtual DVB adapter for Linux"
HOMEPAGE="http://cpn.dyndns.org/projects/dvbloop.shtml https://svn.baycom.de/repos/dvbloop/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

BUILD_TARGETS="build"
MODULE_NAMES="dvbloop(dvbloop)"
