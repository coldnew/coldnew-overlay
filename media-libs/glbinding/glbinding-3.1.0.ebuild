# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="A C++ binding for the OpenGL API, generated using the gl.xml specification"
HOMEPAGE="https://github.com/cginternals/glbinding"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost cppcheck doc examples static-libs tests tools"

RDEPEND="
	>=media-libs/glew-1.6:*
	examples? ( dev-cpp/cpplocate:* >=media-libs/glfw-3.2:* )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0
	doc? ( >=app-doc/doxygen-1.8:* )
	cppcheck? ( dev-util/cppcheck:* )"

EGIT_REPO_URI="https://github.com/cginternals/glbinding.git"
EGIT_BRANCH="master"
EGIT_COMMIT="v3.1.0"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

src_prepare() {
	# user patches:

	# already includes epatch_user:
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOPTION_BUILD_CHECK=$(usex cppcheck)
		-DOPTION_BUILD_TOOLS=$(usex tools)
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TESTS=$(usex tests)
		-DOPTION_BUILD_WITH_BOOST_THREAD=$(usex boost)
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
	# remove dulpicate with mesa
        rm -rf ${D}/usr/include/KHR

# fix multilib-strict QA failures
	mv "${ED%/}"/usr/{lib,$(get_libdir)} || die
}

#pkg_postinst() {
#}
