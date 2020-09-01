# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A qt based library for annotating images"
HOMEPAGE="https://github.com/DamirPorobic/kImageAnnotator"
SRC_URI="https://github.com/DamirPorobic/kImageAnnotator/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5[png]
	>=x11-libs/kcolorpicker-0.1.4"

DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )"

BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/kImageAnnotator-${PV}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
