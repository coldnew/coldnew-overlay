# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils autotools

SRC_URI="https://github.com/DreamSourceLab/DSView/archive/${PV}.tar.gz -> DSView-${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="basic hardware drivers for Dreamsourcelab's dslogic analyzers and input/output file format support"
HOMEPAGE="https://www.dreamsourcelab.com/"

LICENSE="GPL-3"
SLOT="0"
IUSE="static-libs test"
REQUIRED_USE=""

LIB_DEPEND=">=dev-libs/glib-2.32.0[static-libs(+)]
            >=dev-libs/libzip-0.10:=[static-libs(+)]
            >=dev-libs/libserialport-0.1.1:=[static-libs(+)]
	    virtual/libusb:1[static-libs(+)]
	    >=dev-embedded/libftdi-0.16:=[static-libs(+)]
	    >=virtual/libudev-151:=[static-libs(+)]
	    >=media-libs/alsa-lib-1.0:=[static-libs(+)]
"
RDEPEND="!static-libs? ( ${LIB_DEPEND//\[static-libs(+)]} )
	static-libs? ( ${LIB_DEPEND} )"
DEPEND="${LIB_DEPEND//\[static-libs(+)]}
	test? ( >=dev-libs/check-0.9.4 )
	virtual/pkgconfig"

S=${WORKDIR}/DSView-${PV}/${PN}

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	econf
}

# NOTE: this test will failed due to libsigrok4DSL can't really pass it's test
src_test() {
	emake check
}

src_install() {
	default
	prune_libtool_files
}
