# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

RESTRICT="test" # needs some pointy sticks. Seriously.
PYTHON_COMPAT=(python{2_7,3_3,3_4,3_5})

inherit distutils-r1 eutils
DESCRIPTION=" Run applications in VNC desktops. Use for scaling on HiDPI displays. "
HOMEPAGE="https://github.com/feklee/vncdesk"
SRC_URI="https://github.com/feklee/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="WTFPL"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/gtk-vnc[${PYTHON_USEDEP}]
  dev-python/pygobject[${PYTHON_USEDEP}]"
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
