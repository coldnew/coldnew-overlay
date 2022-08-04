# Copyright 2021 Antonio Serrano Hernandez
# Distributed under the terms of the GNU General Public License v3

EAPI=7
PYTHON_COMPAT=( python3_{7..10} )
CMAKE_ECLASS=cmake

inherit git-r3 cmake-multilib

DESCRIPTION="Raspberry PI camera apps that uses libcamera stack"
HOMEPAGE="http://www.raspberrypi.com"
EGIT_REPO_URI="https://github.com/raspberrypi/libcamera-apps.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm"
IUSE="drm X qt5 opencv tensorflow"

RDEPEND="
	media-libs/libcamera
	virtual/jpeg
	media-libs/tiff
	media-libs/libexif
	dev-libs/boost
	drm? ( x11-libs/libdrm )
	X? ( media-libs/libepoxy )
	qt5? ( dev-qt/qtcore:5 dev-qt/qtgui:5 dev-qt/qtwidgets:5 )
"

DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_DRM=$(usex drm 1 0)
		-DENABLE_X11=$(usex X 1 0)
		-DENABLE_QT=$(usex qt5 1 0)
		-DENABLE_OPENCV=$(usex opencv 1 0)
		-DENABLE_TFLITE=$(usex tensorflow 1 0)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}
