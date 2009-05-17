# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="Pycha is a very simple Python package for drawing charts using the great Cairo library."
HOMEPAGE="http://www.lorenzogil.com/projects/pycha/"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/pycairo"
DEPEND="${RDEPEND}
		dev-python/setuptools"

src_install() {
	distutils_src_install
}
