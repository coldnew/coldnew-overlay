EAPI=7

inherit eutils cmake-utils

HOMEPAGE="https://github.com/CoatiSoftware/Sourcetrail"
if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/CoatiSoftware/Sourcetrail.git"
	inherit git-r3
	KEYWORDS="~x86 ~amd64"
else
	SRC_URI="https://github.com/CoatiSoftware/Sourcetrail/archive/${P}.tar.gz"
	S="${WORKDIR}/${PN}-${P}"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="Sourcetrail || ( GPL-2 GPL-3 LGPL-3 ) BSD"
SLOT="0"
IUSE="examples selinux cxx java python"

RDEPEND="
	|| (
		dev-libs/openssl-compat:1.0.0
		=dev-libs/openssl-1.0*:*
	)
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng-compat:1.2
	sys-libs/libudev-compat
	virtual/opengl
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXxf86vm
	selinux? ( sys-libs/libselinux )
	>=dev-libs/boost-1.68
	>=dev-qt/qtgui-5.12.0
	cxx? ( sys-devel/llvm )
	java? (
	      dev-java/maven-bin
	      dev-java/oracle-jdk-bin
	)
	python? (
		dev-lang/python
	)
"

DEPEND="${RDEPEND}"

src_unpack() {
    if [[ ${PV} = *9999* ]]; then
        git-r3_src_unpack
    else
        default_src_unpack
    fi

}

src_prepare() {
    # apply patches
    eapply "${FILESDIR}"/0001-fix-gentoo-build-on-portage.patch

    cmake-utils_src_prepare
}

src_configure() {
  local mycmakeargs=(
      -DLLVM_ENABLE_RTTI="$(usex cxx)"
      -DBUILD_CXX_LANGUAGE_PACKAGE="$(usex cxx)"
      -DBoost_USE_STATIC_LIBS=OFF
      -DBUILD_PYTHON_LANGUAGE_PACKAGE="$(usex python)"
      -DBUILD_JAVA_LANGUAGE_PACKAGE="$(usex java)"
      -DBUILD_SHARED_LIBS=OFF
  )
  cmake-utils_src_configure
}

src_install() {
    # install by cmake
    cmake-utils_src_install
    # generate symlink
    dosym "/usr/Sourcetrail/Sourcetrail.sh" "/usr/bin/sourcetrail"
}
