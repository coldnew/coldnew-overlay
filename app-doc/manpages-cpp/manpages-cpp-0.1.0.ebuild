# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

DESCRIPTION="C++ man pages generater that generates C++ man pagesfrom
cplusplus.com"
SRC_URI="http://github.com/downloads/Aitjcize/manpages-cpp/manpages-cpp-${PV}.tar.gz"
HOMEPAGE="http://github.com/Aitjcize/manpages-cpp"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
DEPEND="app-editors/vim
        app-editors/vim-core
		dev-lang/python[sqlite]
		"


IUSE=""

src_compile() {
	python setup.py build || die "build failed"
}

src_install() {
	python setup.py install --root ${D} || die "install failed"
}

