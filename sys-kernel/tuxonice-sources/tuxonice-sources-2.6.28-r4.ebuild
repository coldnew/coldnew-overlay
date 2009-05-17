# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/tuxonice-sources/tuxonice-sources-2.6.28-r4.ebuild,v 1.1 2009/03/07 22:04:28 nelchael Exp $

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="4"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="TuxOnIce + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~dsd/genpatches/ http://www.tuxonice.net"
IUSE=""

TUXONICE_VERSION="20090305-v1"
TUXONICE_TARGET="2.6.28"
TUXONICE_SRC="current-tuxonice-for-${TUXONICE_TARGET}.patch-${TUXONICE_VERSION}"
TUXONICE_URI="http://www.tuxonice.net/downloads/all/${TUXONICE_SRC}.bz2"

UNIPATCH_LIST="${DISTDIR}/${TUXONICE_SRC}.bz2
               ${FILESDIR}/utf8-kernel-2.6-fonts-1.patch.bz2
               ${FILESDIR}/utf8-kernel-2.6.28-core-2.patch.bz2
               ${FILESDIR}/utf8-kernel-2.6.28-fbcondecor-1.patch.bz2
			  "
UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${TUXONICE_URI}"

KEYWORDS="~amd64 ~x86"

RDEPEND="${RDEPEND}
		>=sys-apps/tuxonice-userui-0.7.3
		>=sys-power/hibernate-script-1.99"

K_EXTRAELOG="If there are issues with this kernel, please direct any
queries to the tuxonice-users mailing list:
http://lists.tuxonice.net/mailman/listinfo/tuxonice-users/"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
