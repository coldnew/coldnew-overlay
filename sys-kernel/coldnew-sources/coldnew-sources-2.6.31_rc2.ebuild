# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 2009/07/13 23:01:39 coldnew Exp $

ETYPE="sources"
inherit kernel-2
detect_version
detect_arch

KEYWORDS="~amd64 ~x86"
IUSE=""
HOMEPAGE=""

DESCRIPTION="Full sources including the Gentoo patchset and some other collected
on Internet by coldnew for personaly use"

SRC_URI="${KERNEL_URI}
mirror://sourceforge/coldnew-overlay/coldnew-patches-${PV}.tar.lzma"


UNIPATCH_LIST=" ${DISTDIR}/coldnew-patches-2.6.31_rc2.tar.lzma"

UNIPATCH_STRICTORDER="yes"
K_PREPATCHED="yes"

