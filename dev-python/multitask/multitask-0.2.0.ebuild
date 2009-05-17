# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.5

inherit distutils

DESCRIPTION="multitask allows Python programs to use generators (a.k.a. coroutines) to perform cooperative multitasking and asynchronous I/O."
HOMEPAGE="http://o2s.csail.mit.edu/o2s-wiki/multitask"
SRC_URI="http://o2s.csail.mit.edu/download/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		dev-python/setuptools"

src_install() {
	distutils_src_install

	insinto /usr/share/${PN}/examples
	doins examples/*
}
