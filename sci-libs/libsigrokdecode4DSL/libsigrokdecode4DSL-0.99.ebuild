# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit eutils python-single-r1 autotools

SRC_URI="https://github.com/DreamSourceLab/DSView/archive/${PV}.tar.gz -> DSView-${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="provide (streaming) protocol decoding functionality for Dreamsourcelab's dslogic"
HOMEPAGE="https://www.dreamsourcelab.com/"

LICENSE="GPL-3"
SLOT="0"
IUSE="static-libs"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND=">=dev-libs/glib-2.28.0
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/DSView-${PV}/${PN}

src_prepare() {
	eautoreconf

	# Only a test program (not installed, and not used by src_test)
	# is used by libsigrok, so disable it to avoid the compile.
	sed -i \
		-e '/build_runtc=/s:yes:no:' \
		configure || die

	eapply_user
}

src_configure() {
	econf $(use_enable static-libs static)
}

# NOTE: this test will failed due to libsigrokdecode4DSL can't really pass it's test
src_test() {
	emake check
}

src_install() {
	default
	prune_libtool_files
}
