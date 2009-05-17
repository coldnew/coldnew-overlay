# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.4

inherit distutils eutils

DESCRIPTION="PyDSSCC - Calibration Software for Distributed Smart Stereo
Cameras"
HOMEPAGE="http://www.mavrinac.com/index.cgi?page=pydsscc"
SRC_URI="http://www.mavrinac.com/files/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE="doc"

RDEPEND="virtual/python
		 >=dev-python/numpy-1.0.4"
DEPEND="${RDEPEND}
		dev-python/setuptools
		doc? ( dev-python/epydoc )"

DOCS="AUTHORS README TODO"

src_install() {
	distutils_src_install
	if use doc; then
		./gendoc.sh
		dohtml -r doc/
	fi
}
