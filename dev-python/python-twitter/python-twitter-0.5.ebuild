# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils eutils

DESCRIPTION="Python Twitter - A python wrapper around the Twitter API"
HOMEPAGE="http://code.google.com/p/python-twitter/"
SRC_URI="http://python-twitter.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="virtual/python
		 dev-python/simplejson"
DEPEND="${RDEPEND}
		dev-python/setuptools"

src_install() {
	distutils_src_install
	if use doc; then
		dodoc doc/twitter.html
	fi
}
