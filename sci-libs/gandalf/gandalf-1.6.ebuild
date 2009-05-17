# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Gandalf - The Fast Computer Vision and Numerical Library"
HOMEPAGE="http://gandalf-library.sourceforge.net"
SRC_URI="mirror://sourceforge/gandalf-library/gandalf.1.6.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="doc lapack jpeg png tiff opengl glut"

RDEPEND="lapack? ( virtual/lapack )
		 jpeg? ( media-libs/jpeg )
		 png? ( media-libs/libpng )
		 tiff? ( media-libs/tiff )
		 opengl? ( glut? ( virtual/glut ) )"
DEPEND="${RDEPEND}
	    sys-devel/libtool
        doc? ( app-doc/doxygen )"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-destdir.patch"
}


src_compile() {
	econf \
		$(use_with lapack) \
		$(use_with jpeg) \
		$(use_with png) \
		$(use_with tiff) \
		$(use_with opengl) \
		$(use_with glut) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGELOG README
	if use doc; then
		cd "${S}"
		emake docsource || die "doc generation failed"
		doxygen doxyfile
		./postprocess
		dohtml -r doc/reference/*
	fi
}
