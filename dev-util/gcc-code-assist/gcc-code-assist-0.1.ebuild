# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.4.4-r1.ebuild,v 1.2 2010/06/28 11:32:42 jer Exp $

PATCH_VER="1.0"
UCLIBC_VER="1.0"

ETYPE="gcc-code-assist"

TOOLCHAIN_GCC_PV="4.4.4"

inherit toolchain versionator

S="${WORKDIR}/${P}-${TOOLCHAIN_GCC_PV}"

GCC_CA_NAME="${P}-${TOOLCHAIN_GCC_PV}"
GCC_URI_ORIGIN="mirror://gnu/gcc/gcc-${GCC_PV}/gcc-${GCC_RELEASE_VER}.tar.bz2"
GCC_CODE_ASSIST_URI="http://cx4a.org/pub/gccsense/${GCC_CA_NAME}.tar.bz2"
SRC_URI=$(echo ${SRC_URI} | sed -e \
	"s!${GCC_URI_ORIGIN}!${GCC_CODE_ASSIST_URI}!")
GCC_A_FAKEIT="${GCC_CA_NAME}.tar.bz2"

DESCRIPTION="The most intelligent development tools for C/C++."

LICENSE="GPL-3 LGPL-3 || ( GPL-3 libgcc libstdc++ gcc-runtime-library-exception-3.1 ) FDL-1.2"
KEYWORDS="~amd64 ~x86-fbsd"
IUSE="nls"
RDEPEND=">=sys-libs/zlib-1.1.4
	virtual/libiconv
	>=dev-libs/gmp-4.2.1
	>=dev-libs/mpfr-2.3.2
	>=sys-libs/ncurses-5.2-r2
	>=sys-devel/gcc-4.4
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	test? ( >=dev-util/dejagnu-1.4.4 >=sys-devel/autogen-5.5.4 )
	>=sys-apps/texinfo-4.8
	>=sys-devel/bison-1.875
	elibc_glibc? ( >=sys-libs/glibc-2.8 )
	>=sys-devel/binutils-2.15.94"

src_unpack() {
	gcc_src_unpack

	use vanilla && return 0

	sed -i 's/use_fixproto=yes/:/' gcc/config.gcc #PR33200

	[[ ${CHOST} == ${CTARGET} ]] && epatch "${FILESDIR}"/gcc-spec-env.patch

	[[ ${CTARGET} == *-softfloat-* ]] && epatch "${FILESDIR}"/4.4.0/gcc-4.4.0-softfloat.patch
}

pkg_setup() {
	gcc_pkg_setup

	use hppa && STAGE1_CFLAGS="-O0"
}

gcc-code-assist_src_unpack() {
	gcc-compiler_src_unpack
	epatch "${FILESDIR}"/${P}-gcc.patch
}

gcc-code-assist-configure() {
	# disable multilib support
	if [[ ${CTARGET} == *-linux* ]] ; then
		confgcc="${confgcc} --disable-multilib"
	fi

	if has mudflap ${IUSE} ; then
		confgcc="${confgcc} $(use_enable mudflap libmudflap)"
	else
		confgcc="${confgcc} --disable-libmudflap"
	fi

	if want_libssp ; then
		confgcc="${confgcc} --enable-libssp"
	else
		export gcc_cv_libc_provides_ssp=yes
		confgcc="${confgcc} --disable-libssp"
	fi

	if tc_version_is_at_least "4.2" ; then
		confgcc="${confgcc} $(use_enable openmp libgomp)"
	fi

	# enable the cld workaround until we move things to stable.
	# by that point, the rest of the software out there should
	# have caught up.
	if tc_version_is_at_least "4.3" ; then
		if ! has ${ARCH} ${KEYWORDS} ; then
			confgcc="${confgcc} --enable-cld"
		fi
	fi

	# Stick the python scripts in their own slotted directory
	# bug #279252
	#
	#  --with-python-dir=DIR
	#    Specifies where to install the Python modules used for aot-compile. DIR
	#  should not include the prefix used in installation. For example, if the
	#  Python modules are to be installed in /usr/lib/python2.5/site-packages,
	#  then –with-python-dir=/lib/python2.5/site-packages should be passed.
	#
	# This should translate into "/share/gcc-data/${CTARGET}/${GCC_CONFIG_VER}/python"
	if tc_version_is_at_least "4.4" ; then
		confgcc="${confgcc} --with-python-dir=${DATAPATH/$PREFIX/}/python"
	fi

	confgcc="${confgcc} --disable-libgcj --program-suffix=-code-assist"

	GCC_LANG="c"
	is_cxx && GCC_LANG="${GCC_LANG},c++"

	einfo "configuring for GCC_LANG: ${GCC_LANG}"
}

gcc-code-assist_pkg_preinst() {
	:
}

gcc-code-assist_pkg_postinst() {
	:
}

gcc-code-assist_pkg_prerm() {
	:
}

gcc-code-assist_pkg_postrm() {
	:
}

gcc-code-assist_src_install() {
	local x=

	cd "${WORKDIR}"/build
	# Do allow symlinks in private gcc include dir as this can break the build
	find gcc/include*/ -type l -print0 | xargs -0 rm -f
	# Remove generated headers, as they can cause things to break
	# (ncurses, openssl, etc).
	for x in $(find gcc/include*/ -name '*.h') ; do
		grep -q 'It has been auto-edited by fixincludes from' "${x}" \
			&& rm -f "${x}"
	done
	# Do the 'make install' from the build directory
	S=${WORKDIR}/build \
	emake -j1 DESTDIR="${D}" install || die

	dodir /${PREFIX}/bin

	for x in gcc g++; do
		dosym /${BINPATH}/${x}-code-assist /${PREFIX}/bin/${x}-code-assist
	done

	rm -r "${D}"/${PREFIX}/lib "${D}"/${PREFIX}/share \
		"${D}"/${PREFIX}/$(get_libdir) "${D}"/${PREFIX}/libexec/gcc \
		"${D}"/${PREFIX}/libexec/${PN}/${CTARGET}/${GCC_CONFIG_VER}/install-tools \
		"${D}"/${BINPATH}/${CTARGET}-gcc-${GCC_CONFIG_VER}

	dodir ${PREFIX}/$(get_libdir)/${PN}/${CTARGET}/${GCC_CONFIG_VER}
	for x in include include-fixed; do
		dosym ${PREFIX}/$(get_libdir)/gcc/${CTARGET}/${GCC_CONFIG_VER}/$x \
			${PREFIX}/$(get_libdir)/${PN}/${CTARGET}/${GCC_CONFIG_VER}/$x
	done
}
