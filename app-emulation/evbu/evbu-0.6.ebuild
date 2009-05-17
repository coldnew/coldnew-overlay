# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.1

inherit distutils python

DESCRIPTION="EVBU simulates the execution of a 68HC11 microcontroller."
HOMEPAGE="http://claymore.engineer.gvsu.edu/~steriana/Python/"
SRC_URI="http://claymore.engineer.gvsu.edu/%7Esteriana/courses/Downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python
        dev-python/setuptools"
RDEPEND="virtual/python
         >=dev-python/wxpython-2.3.2"

DOCS="COPYING README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-wx.patch
	epatch "${FILESDIR}"/${P}-pysimwx.patch
	sed '$d' < misc/evbu > misc/evbu-new
	mv misc/evbu-new misc/evbu
	echo python $(python_get_sitedir)/${PN}/${PN}.py \$\* >> misc/evbu
}

src_install() {
	distutils_src_install
	dobin misc/evbu
	dohtml doc/*
}

pkg_postrm() {
	python_mod_cleanup
}
