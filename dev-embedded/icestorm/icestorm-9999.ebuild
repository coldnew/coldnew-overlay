# Copyright 2019-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2 or later

EAPI=6

if [[ ${PV} == *9999 ]] ; then
    SCM="git-r3"
    EGIT_REPO_URI="https://github.com/cliffordwolf/${PN}.git"
fi

inherit eutils ${SCM}

DESCRIPTION="Project IceStorm - Lattice iCE40 FPGAs Bitstream Documentaion (Reverse Engineered)"
HOMEPAGE="https://github.com/cliffordwolf/icestorm"

if [[ ${PV} == *9999 ]] ; then
    SRC_URI=""
    KEYWORDS="~amd64 ~x86"
else
    SRC_URI="https://github.com/cliffordwolf/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"
IUSE=""
REQUIRED_USE=""

RDEPEND="dev-libs/boost"
DEPEND="${RDEPEND}"

src_compile() {
    emake PREFIX="${D}"/usr
}

src_install() {
    emake PREFIX="${D}"/usr install
}
