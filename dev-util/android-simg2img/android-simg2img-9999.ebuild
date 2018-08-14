# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

HOMEPAGE="https://github.com/anestisb/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit eutils ${ECLASS}

DESCRIPTION="Tool to convert Android sparse images to raw images"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc"

MAKEOPTS+=" -j1"

src_install() {
	local bin
	local BINS="simg2img simg2simg img2simg append2simg"

	for bin in ${BINS}; do
		dobin ${bin}
	done
}
