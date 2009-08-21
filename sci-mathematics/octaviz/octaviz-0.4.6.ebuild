# Copyright 2007 Peter A. Gustafson
# Distributed under the terms of the GNU General Public License v2
inherit autotools eutils

DESCRIPTION="Octaviz is a visualization system for Octave using VTK"
HOMEPAGE="http://octaviz.sourceforge.net/"
LICENSE="GPL"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND=">=sci-libs/vtk-5.0.4
>=sci-mathematics/octave-3.0.0
media-libs/jpeg
media-libs/tiff
media-libs/libpng
sys-libs/zlib
dev-libs/expat"

DEPEND=">=dev-util/cmake-2.4
		${RDEPEND}"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

src_compile() {
	cd ${WORKDIR}/${PN}
	cmake ${CMAKE_VARIABLES} . || die "cmake
		configuration failed"
	emake -j1 || die "emake failed"
}

src_install() {
	cd ${WORKDIR}/${PN}
	make install DESTDIR=${D} || die "make install
		failed"
}

