# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

HOMEPAGE="https://github.com/anestisb/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz"
fi

inherit eutils ${ECLASS}

DESCRIPTION="Tools to work with Android boot images"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc"

RDEPEND=""

DEPEND="${RDEPEND}"

MAKEOPTS+=" -j1"

src_prepare() {
	default
	sed -i -e "s|-Werror||" Makefile || die
}

src_install() {
	local bin
	# mkbootimg conflicts with dev-util/android-tools
	# may need to rename to install
#	local BINS="mkbootimg unpackbootimg"
	local BINS="unpackbootimg"

	for bin in ${BINS}; do
		dobin ${bin}
	done
}
