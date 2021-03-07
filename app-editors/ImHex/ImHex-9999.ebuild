# app-editors/ImHex
# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A hex editor for reverse engineers, programmers, and eyesight"
HOMEPAGE="https://github.com/WerWolv/ImHex"
SRC_URI=""
EGIT_REPO_URI="https://github.com/WerWolv/ImHex.git"

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit git-r3 python-single-r1 cmake

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=""
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	media-libs/glfw
	sys-apps/file
	dev-libs/openssl
	dev-libs/capstone
	sys-devel/llvm
	dev-cpp/nlohmann_json
	media-libs/glm
	"
BDEPEND="${DEPEND}"

CMAKE_BUILD_TYPE="Release"

#PATCHES=(
#    "${FILESDIR}"/0001-fix-installation-dir-on-linux.patch
#)

# FIXME: this ebuild doen't support multilib
# The tools in /usr/lib/go should not cause the multilib-strict check to fail.
# QA_MULTILIB_PATHS="usr/lib/.*"

src_configure() {
    local mycmakeargs=(
        -DBUILD_SHARED_LIBS=OFF
    )
    cmake_src_configure
}

src_install() {
    # install by cmake
    cmake_src_install

    cd "${D}"

    # move imhex binary to /usr/share/imhex/imhex
    insinto /usr/share/imhex
    insopts -m 0755
    doins usr/bin/imhex || die "doins usr/bin failed"
    rm usr/bin/imhex

    # move libimhex.so to  /usr/share/imhex/libimhex.so 
    insinto /usr/share/imhex
    insopts -m 0755
    doins usr/lib/libimhex.so || die "doins usr/lib failed"
    rm usr/lib/libimhex.so

    # generate wrapper for /usr/bin/imhex
    cat << EOF >imhex.sh
#!/bin/bash
export SETTINGS_FOLDER=$HOME/.local/share/imhex
mkdir -p ${SETTINGS_FOLDER} > /dev/null 2>&1
cd $SETTINGS_FOLDER
export LD_LIBRARY_PATH=/usr/share/imhex
exec /usr/share/imhex/imhex "$@"
EOF
    insinto /usr/share/imhex
    insopts -m 0755
    doins imhex.sh  || die "doins usr/share/imhex/imhex.sh failed"
    rm -f imhex.sh
    
    # generate symlink
    dosym "/usr/share/imhex/imhex.sh" "/usr/bin/imhex"
}
