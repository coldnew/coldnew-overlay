# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

RESTRICT="test" # needs some pointy sticks. Seriously.
PYTHON_COMPAT=(python{3_3,3_4,3_5})

inherit distutils-r1 eutils python-r1
DESCRIPTION=" Run applications in VNC desktops. Use for scaling on HiDPI displays. "
HOMEPAGE="https://github.com/feklee/vncdesk"
SRC_URI="https://github.com/feklee/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="WTFPL"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-libs/gtk-vnc[${PYTHON_USEDEP}]
  dev-python/pygobject[${PYTHON_USEDEP}]
  =net-misc/tigervnc-1.4.2-r2[server,-xorgmodule]"
DEPEND="${RDEPEND}"

src_prepare() {
    cat << EOF >vncdesk/font_path.py
font_path = ','.join(['/usr/share/fonts/misc/',
                      '/usr/share/fonts/75dpi/',
                      '/usr/share/fonts/100dpi/',
                      '/usr/share/fonts/Type1/'])
EOF
}

python_compile_all() {
    :
}

python_test() {
    :
}
