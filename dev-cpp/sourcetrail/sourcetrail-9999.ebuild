# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake

HOMEPAGE="https://github.com/CoatiSoftware/Sourcetrail"
DESCRIPTION="A cross-platform source explorer for C/C++ and Java"
if [[ ${PV} = *9999* ]]; then
    EGIT_REPO_URI="https://github.com/CoatiSoftware/Sourcetrail.git"
    inherit git-r3
    KEYWORDS="~x86 ~amd64"
else
    SRC_URI="https://github.com/CoatiSoftware/Sourcetrail/archive/${PV}.tar.gz"
    S="${WORKDIR}/Sourcetrail-${PV}"
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
        dev-qt/qtprintsupport
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

PATCHES=(
    "${FILESDIR}"/0001-fix-gentoo-clang-header.patch
    "${FILESDIR}"/0002-fix-linux-make-install.patch
)

src_unpack() {
    if [[ ${PV} = *9999* ]]; then
        git-r3_src_unpack
    else
        default_src_unpack
    fi
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
    cmake_src_configure
}

src_install() {
    # install by cmake
    cmake_src_install
    # generate symlink
    dosym "/usr/share/Sourcetrail/Sourcetrail" "/usr/bin/sourcetrail"
}
