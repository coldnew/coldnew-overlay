# SPDX-License-Identifier: GPL-2.0-only
# Copyright 2019 Google Inc.

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit git-r3 meson python-any-r1

DESCRIPTION="Camera support library for Linux"
HOMEPAGE="http://libcamera.org"
EGIT_REPO_URI="https://git.libcamera.org/libcamera/libcamera.git"
EGIT_BRANCH="master"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="debug doc test udev raspberrypi gstreamer qt5 tracing v4l2"

RDEPEND="
	>=net-libs/gnutls-3.3:=
	udev? ( virtual/libudev )
	debug? ( sys-libs/libunwind )
	raspberrypi? ( dev-libs/boost )
	gstreamer? ( media-libs/gstreamer:1.0 media-libs/gst-plugins-base:1.0 )
	dev-libs/libevent
	qt5? ( dev-qt/qtcore:5 dev-qt/qtgui:5 dev-qt/qtwidgets:5 media-libs/tiff )
	tracing? ( dev-util/lttng-ust dev-util/lttng-tools dev-python/jinja )
"

DEPEND="
	${RDEPEND}
	dev-libs/openssl
	$(python_gen_any_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]')
	$(python_gen_any_dep 'dev-python/ply[${PYTHON_USEDEP}]')
	$(python_gen_any_dep 'dev-python/jinja[${PYTHON_USEDEP}]')
	>=dev-util/meson-0.55
	dev-util/ninja
	virtual/pkgconfig
	doc? ( dev-python/sphinx app-doc/doxygen media-gfx/graphviz dev-texlive/texlive-latexextra )
"

src_configure() {
	if use raspberrypi; then
        ipas_option="ipu3,raspberrypi,rkisp1,vimc"
        pipelines_option="ipu3,raspberrypi,rkisp1,simple,uvcvideo,vimc"
    else
        ipas_option="ipu3,rkisp1,vimc"
        pipelines_option="ipu3,rkisp1,simple,uvcvideo,vimc"
    fi
	local emesonargs=(
		$(meson_feature doc documentation)
		$(meson_use test)
		$(meson_feature gstreamer)
		$(meson_feature tracing)
		$(meson_use v4l2)
		$(meson_use test)
		-Dipas=${ipas_option}
		-Dpipelines=${pipelines_option}
		-Dlc-compliance=disabled
		--buildtype $(usex debug debug plain)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
