# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.4

EGIT_REPO_URI="git://glorfindel.mavrinac.com/${PN}.git"
EGIT_BRANCH="master"

inherit distutils eutils git

DESCRIPTION="PyDSSCC - Calibration Software for Distributed Smart Stereo
Cameras"
HOMEPAGE="http://www.mavrinac.com/index.cgi?page=pydsscc"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
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
