# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

RESTRICT="test" # needs some pointy sticks. Seriously.
PYTHON_COMPAT=(python{3_4,3_5,3_6,3_7})

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
