# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 2009/07/13 23:01:39 coldnew Exp $

ETYPE="sources"
inherit kernel-2
detect_version
detect_arch

COMPRESSTYPE="lzma"

KEYWORDS="~amd64 ~x86"
IUSE=""
HOMEPAGE=""

DESCRIPTION="Full sources including the Gentoo patchset and some other stuff collected
on  the Internet by coldnew for personaly use"

SRC_URI="${KERNEL_URI}
mirror://sourceforge/coldnew-overlay/coldnew-patches-${PVR}.tar.${COMPRESSTYPE}"

UNIPATCH_LIST=" ${DISTDIR}/coldnew-patches-${PVR}.tar.${COMPRESSTYPE}"

UNIPATCH_STRICTORDER="yes"
K_PREPATCHED="yes"
K_NOSETEXTRAVERSION="don't_set_it"
K_EXTRAEWARN="This is for coldnew personal use, I won't take any responsibility
for it"
K_SECURITY_UNSUPPORTED="yes"
