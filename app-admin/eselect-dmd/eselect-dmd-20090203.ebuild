# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Manages configuration for DMD versions and libraries"
HOMEPAGE="http://www.assembla.com/wiki/show/d-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.2"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}/dmd.eselect-${PVR}" dmd.eselect || die
}
