# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Kamaelia is a Python library for concurrent programming."
HOMEPAGE="http://www.kamaelia.org/Home"
SRC_URI="http://www.kamaelia.org/release/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		dev-python/setuptools"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f ez_setup.py
}

src_install() {
	distutils_src_install
}
