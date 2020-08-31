# Copyright 2019-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later

EAPI=7

if [[ ${PV} == *9999 ]] ; then
    SCM="git-r3"
    EGIT_REPO_URI="https://github.com/YosysHQ/${PN}.git"
fi

inherit cmake-utils ${SCM}

DESCRIPTION="nextpnr portable FPGA place and route tool"
HOMEPAGE="https://github.com/YosysHQ/nextpnr"

if [[ ${PV} == *9999 ]] ; then
    SRC_URI=""
    KEYWORDS="~amd64 ~x86"
else
    SRC_URI="https://github.com/YosysHQ/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE="ice40 ecp5"
REQUIRED_USE=""

RDEPEND="${DEPEND}"
DEPEND="ice40? ( sci-electronics/icestorm
	         >=sci-electronics/yosys-0.8 )
	ecp5? ( sci-electronics/prjtrellis
	        >sci-electronics/yosys-0.8 )
	dev-qt/qtcore:5
	dev-libs/boost
	dev-cpp/eigen"

src_configure() {
	local mycmakeargs=(
		$(usex ice40 $(usex ecp5 "-DARCH=all" "-DARCH=ice40") $(usex ecp5 "-DARCH=ecp5" "-DARCH=generic"))
		$(usex ice40 -DICEBOX_ROOT=/usr/share/icebox "")
		$(usex ecp5 -DTRELLIS_ROOT=/usr/share/trellis "")
	)
	cmake-utils_src_configure
}
