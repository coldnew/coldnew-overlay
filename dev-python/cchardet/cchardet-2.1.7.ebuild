# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )


inherit distutils-r1

DESCRIPTION="3000 times faster than chardet"
HOMEPAGE="https://github.com/PyYoshi/cChardet"
SRC_URI="mirror://pypi/c/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT=0

KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="dev-python/cython[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"
