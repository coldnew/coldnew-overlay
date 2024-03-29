# Copyright 2019-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later

EAPI=8

if [[ ${PV} == *9999 ]] ; then
    SCM="git-r3"
    EGIT_REPO_URI="https://github.com/cliffordwolf/${PN}.git"
    inherit ${SCM}
fi

DESCRIPTION="Project IceStorm - Lattice iCE40 FPGAs Bitstream Documentaion (Reverse Engineered)"
HOMEPAGE="http://www.clifford.at/icestorm/"

if [[ ${PV} == *9999 ]] ; then
    SRC_URI=""
    KEYWORDS="**"
else
    SRC_URI="https://github.com/cliffordwolf/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE=""
REQUIRED_USE=""

RDEPEND="dev-libs/boost
	 dev-embedded/libftdi
	 media-gfx/graphviz
	 sci-electronics/iverilog
	 dev-lang/tcl"
DEPEND="${RDEPEND}"

src_compile() {
    emake PREFIX="${D}"/usr
}

src_install() {
    emake PREFIX="${D}"/usr install
}
