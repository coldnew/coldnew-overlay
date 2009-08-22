# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdrm/libdrm-2.3.0.ebuild,v 1.8 2007/05/20 20:47:52 jer Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

EGIT_BRANCH="r6xx-r7xx-3d" 

inherit autotools x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/~agd5f/drm" 

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="http://dri.freedesktop.org/"
SRC_URI=""

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

IUSE=""
RDEPEND="dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}"
RESTRICT="test" # see bug #236845

#CONFIGURE_OPTIONS="--enable-udev --enable-radeon-experimental-api"

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "libdrm's ABI may have changed without change in library name"
	ewarn "Please rebuild media-libs/mesa, x11-base/xorg-server and"
	ewarn "your video drivers in x11-drivers/*."
}
