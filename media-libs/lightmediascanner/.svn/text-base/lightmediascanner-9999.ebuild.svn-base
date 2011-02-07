# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI=git://staff.get-e.org/users/barbieri/${PN}.git

inherit git

DESCRIPTION="LightMediaScanner"
HOMEPAGE="http://lms.garage.maemo.org/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE="libmp4v2 png jpeg flac ogg"

DEPEND="libmp4v2? ( media-libs/libmp4v2 )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	flac? ( media-libs/flac )
	ogg? ( media-libs/libogg )
"
RDEPEND="dev-db/sqlite
	 dev-util/git"

src_compile() {
	./autogen.sh --prefix=/usr || die "autogen.sh failed"
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
