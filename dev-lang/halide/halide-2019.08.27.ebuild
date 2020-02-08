EAPI=6
DESCRIPTION="Language for image processing and computational photography"
HOMEPAGE="http://halide-lang.org"
EGIT_REPO_URI="git://github.com/halide/Halide.git"
LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT=0

EGIT_COMMIT="65c26cba6a3eca2d08a0bccf113ca28746012cc3"

: ${CMAKE_MAKEFILE_GENERATOR:=ninja}
CMAKE_MIN_VERSION=3.6.1-r1

# Keep in sync with sys-devel/llvm
ALL_LLVM_TARGETS=( ARM AArch64 Hexagon Mips NVPTX PowerPC X86 )
ALL_LLVM_TARGETS=( "${ALL_LLVM_TARGETS[@]/#/llvm_targets_}" )

LLVM_TARGET_USEDEPS=${ALL_LLVM_TARGETS[@]/%/?}

IUSE="metal +opencl +opengl ${ALL_LLVM_TARGETS[*]}"

inherit cmake-utils git-r3 llvm

RDEPEND="
 opencl? ( virtual/opencl )
 opengl? ( virtual/opengl )
 sys-libs/zlib
 media-libs/libpng
 sys-devel/llvm:=[${LLVM_TARGET_USEDEPS// /,}]
"

DEPEND="
 $RDEPEND
"

#src_unpack() {
#	git-r3_src_unpack
#}

src_configure() {
	local LLVM_VERSION=$(${ROOT}/usr/bin/llvm-config --version)
	LLVM_VERSION=${LLVM_VERSION//./}
	LLVM_VERSION=${LLVM_VERSION//0/}

	local mycmakeargs=(
	 -DBUILD_AOT_TUTORIAL:BOOL="0"
	 -DHALIDE_SHARED_LIBRARY:BOOL="1"
	 -DLLVM_BIN:PATH="${ROOT}/usr/bin"
	 -DLLVM_LIB:PATH="${ROOT}/usr/lib"
	 -DLLVM_INCLUDE:PATH="${ROOT}/usr/include"
	 -DLLVM_VERSION:STRING="${LLVM_VERSION}"
	 -DTARGET_AARCH64:BOOL="$(usex llvm_targets_AArch64)"
	 -DTARGET_ARM:BOOL="$(usex llvm_targets_ARM)"
	 -DTARGET_HEXAGON:BOOL="$(usex llvm_targets_Hexagon)"
	 -DTARGET_METAL:BOOL="$(usex metal)"
	 -DTARGET_MIPS:BOOL="$(usex llvm_targets_Mips)"
	 -DTARGET_OPENCL:BOOL="$(usex opencl)"
	 -DTARGET_OPENGL:BOOL="$(usex opengl)"
	 -DTARGET_OPENGLCOMPUTE:BOOL="$(usex opengl)"
	 -DTARGET_POWERPC:BOOL="$(usex llvm_targets_PowerPC)"
	 -DTARGET_PTX:BOOL="$(usex llvm_targets_NVPTX)"
	 -DTARGET_X86:BOOL="$(usex llvm_targets_X86)"
	 -DWITH_APPS:BOOL="0"
	 -DWITH_TESTS:BOOL="0"
	 -DWITH_TUTORIALS:BOOL="0"
	)
	cmake-utils_src_configure
}

src_install() {
	cd "${BUILD_DIR}"
	dobin bin/HalideTraceViz
	#dobin bin/bitcode2cpp
	dolib lib/libHalide.so
	insinto /usr/include
	doins include/*
	insinto /usr/lib/pkgconfig
	echo '
prefix=/usr
exec_prefix=
libdir=/usr/lib64
includedir=/include

Name: Halide
Description: Language for image processing and computational photography
Version: 0.1
Libs: -L/usr/lib -lHalide ' $(llvm-config --system-libs) '
Cflags: -I/usr/include
Requires: ncurses
' > Halide.pc
	doins Halide.pc
}

