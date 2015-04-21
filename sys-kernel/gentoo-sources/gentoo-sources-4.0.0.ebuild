# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-4.0.0.ebuild,v 1.1 2015/04/13 00:28:19 mpagano Exp $

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="1"
K_DEBLOB_AVAILABLE="0"
inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"
IUSE="deblob experimental"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

UNIPATCH_LIST="${FILESDIR}/revert-acpi_support_osi_darwin.patch \
               ${FILESDIR}/hid-apple.patch"
UNIPATCH_STRICTORDER=1

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
