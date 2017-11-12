# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

RESTRICT="test" # needs some pointy sticks. Seriously.
PYTHON_COMPAT=(python{2_6,2_7})

inherit distutils-r1 eutils python-r1
DESCRIPTION="python-based serial dump and timing program - good for embedded Linux development"
HOMEPAGE="https://github.com/tbird20d/grabserial"
SRC_URI="https://github.com/tbird20d/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPLv2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pyserial-2.6"
DEPEND="${RDEPEND}"

src_prepare() {
    :
}

python_compile_all() {
    :
}

python_test() {
    :
}
