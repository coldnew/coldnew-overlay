# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A size profiler for binaries"
HOMEPAGE="https://github.com/google/bloaty"
SRC_URI="https://github.com/google/bloaty/releases/download/v${PV}/${PN}-${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
    dev-libs/protobuf
    dev-libs/re2
    dev-libs/capstone
"
RDEPEND="${DEPEND}"

