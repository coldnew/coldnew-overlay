# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://anongit.freedesktop.org/git/mesa/drm"

inherit eutils autotools git

PATCHDATE="20090418"

DESCRIPTION="X11 DRM utilities and test programs"
HOMEPAGE="http://dri.freedesktop.org/wiki/"
SRC_URI="http://dev.gentoo.org/~battousai/distfiles/${P}-use-system-libdrm-${PATCHDATE}.patch.bz2"
EGIT_PROJECT="libdrm"

LICENSE="X11"
SLOT="0"

# Keywords inherited from x11-drm ebuild, where these used to be.
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"

IUSE=""

DEPEND="x11-libs/libdrm"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack

	cd "${WORKDIR}"
	unpack ${P}-use-system-libdrm-${PATCHDATE}.patch.bz2

	cd "${S}"
	epatch "${WORKDIR}"/${P}-use-system-libdrm-${PATCHDATE}.patch

	eautoreconf -v --install
}

src_compile() {
	econf || die "econf failed"

	cd "${S}"/tests
	emake || die "emake failed"
}

src_install() {
	cd "${S}"/tests
	dobin dristat drmstat modeprint/modeprint modetest/modetest || die
}
