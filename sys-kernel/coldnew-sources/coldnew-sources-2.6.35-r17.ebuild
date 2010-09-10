# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.6.35-r5.ebuild,v 1.1 2010/08/27 23:56:06 mpagano Exp $

ETYPE="sources"
K_PREPATCHED="yes"
K_NOSETEXTRAVERSION="don't_set_it"
K_SECURITY_UNSUPPORTED="yes"
inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""
HOMEPAGE=""

DESCRIPTION="Full sources including the Gentoo patchset and some other stuff
collected on  the Internet by coldnew for personaly use"
SRC_URI="${KERNEL_URI}
mirror://sourceforge/coldnew-overlay/coldnew-patches-${PV}-r17.tar.gz"

UNIPATCH_LIST=" ${DISTDIR}/coldnew-patches-${PV}-r17.tar.gz"
UNIPATCH_STRICTORDER="yes"

K_EXTRAEINFO="This is for coldnew personal use, I won't take any responsibility
for it"

pkg_postinst() {
	kernel-2_pkg_postinst
}

