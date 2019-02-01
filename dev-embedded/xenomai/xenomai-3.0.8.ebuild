# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils
DESCRIPTION="Xenomai brings POSIX and traditional RTOS APIs for porting time-critical applications to Linux-based platforms. "
HOMEPAGE="https://xenomai.org/"
SRC_URI="https://xenomai.org/downloads/xenomai/stable/${PN}-${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPLv2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="+smp +mercury debug doc"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
    econf \
	$(use_enable smp smp) \
	$(use_enable debug debug) \
	$(use_enable doc doc-build) \
	--prefix="${EPREFIX}"/usr/xenomai \
	|| die
}
