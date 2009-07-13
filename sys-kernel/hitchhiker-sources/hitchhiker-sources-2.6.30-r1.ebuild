# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Full linux-2.6 kernel sources patched with the Gentoo, Reiser4,
squashfs-lzma and aufs patches"
HOMEPAGE="http://ben.liveforge.org/"
SRC_URI="${KERNEL_URI}
        http://dl.liveforge.org/${PN}/${PV}/hh-patches-${PVR}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"

UNIPATCH_LIST="${DISTDIR}/hh-patches-${PVR}.tar.bz2
               ${FILESDIR}/utf8-kernel-2.6-fonts2.patch.bz2
               ${FILESDIR}/utf8-kernel-2.6-core-1.patch.bz2
               ${FILESDIR}/utf8-kernel-2.6-fbcondecor-1.patch.bz2
"
UNIPATCH_STRICTORDER="yes"
K_PREPATCHED="yes"
K_NOSETEXTRAVERSION="don't_set_it"
K_EXTRAEWARN="While based on Gentoo patches, these sources are not
officially supported!"
