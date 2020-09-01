# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A Qt based Color Picker with popup menu library"
HOMEPAGE="https://github.com/DamirPorobic/kColorPicker"
SRC_URI="https://github.com/DamirPorobic/kColorPicker/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5[png]"

DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )"

BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/kColorPicker-${PV}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
