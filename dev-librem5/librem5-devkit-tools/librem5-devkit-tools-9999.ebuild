# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

if [[ ${PV} == *9999 ]] ; then
    SCM="git-r3"
    EGIT_REPO_URI="https://source.puri.sm/Librem5/librem5-devkit-tools.git"
fi

inherit eutils ${SCM}

DESCRIPTION="Tools for the Librem5-evk (devkit)"
HOMEPAGE="https://arm01.puri.sm/job/debs/job/deb-mfgtools-buster-amd64/"


if [[ ${PV} == *9999 ]] ; then
   SRC_URI=""
else
   SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v0.0.2/${PN}-v${PV}.tar.gz"
   S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=" ~amd64"
IUSE=""

DEPEND="
    dev-librem5/uuu
    dev-python/python-jenkins
    dev-python/tqdm
    dev-python/pyyaml
"
RDEPEND="${DEPEND}"


# disable compile stage
src_compile() {
    :
}

# disable test stage
src_test() {
    :
}

src_install() {
    # install /opt
    insinto /opt/librem5-devkit-tools
    insopts -m 0755
    doins -r ${S}/* || die "doins /opt failed"
}
