# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/x11-drm/x11-drm-20070314.ebuild,v 1.2 2007/03/14 18:18:53 battousai Exp $

EGIT_BRANCH="r6xx-r7xx-3d"

EAPI="2"

EGIT_REPO_URI="git://anongit.freedesktop.org/~agd5f/drm" 
EGIT_PROJECT="libdrm"

[[ ${PV} = 9999* ]] && GIT_ECLASS="git"

inherit eutils x11 linux-mod ${GIT_ECLASS}

DESCRIPTION="DRM Kernel Modules for X11"
HOMEPAGE="http://dri.sf.net"
PATCHVER="0.2"
#SRC_PATCHES="http://dev.gentoo.org/~dberkholz/distfiles/${P}-gentoo-${PATCHVER}.tar.bz2"
if [[ $PV = 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="${SRC_PATCHES}
		mirror://gentoo/linux-drm-${PV}-kernelsource.tar.bz2"
fi

LICENSE="X11"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"

# ! IMPORTANT:
# this is really out of sync with MESA, should we add here or remove from mesa?
IUSE_VIDEO_CARDS="
	video_cards_mach64
	video_cards_mga
	video_cards_r128
	video_cards_radeon
	video_cards_radeonhd
	video_cards_savage
	video_cards_sis
	video_cards_sunffb
	video_cards_tdfx
	video_cards_via"
IUSE="${IUSE_VIDEO_CARDS} kernel_FreeBSD kernel_linux"

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
# Tests require user intervention (see bug #236845)
RESTRICT="strip test"

DEPEND="
	kernel_linux? ( virtual/linux-sources )
	kernel_FreeBSD? (
		sys-freebsd/freebsd-sources
		sys-freebsd/freebsd-mk-defs
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/drm"

pkg_setup() {
	_set_build_type

	# Setup the kernel's stuff.
	kernel_setup

	# Set video cards to build for.
	set_vidcards

	# Determine which -core dir we build in.
	if [[ $CORE = fbsd ]]; then
		SRC_BUILD="${S}/bsd-core"
	else
		SRC_BUILD="${S}/linux-core"
	fi
}

src_unpack() {
	[[ $PV = 9999* ]] && git_src_unpack || unpack ${A}
}

src_prepare() {
	cd "${WORKDIR}"

	# Apply patches
	if [[ ${PV} != 9999* && -n ${SRC_PATCHES} ]]; then
		EPATCH_FORCE="yes" \
		EPATCH_SOURCE="${WORKDIR}/patches" \
		EPATCH_SUFFIX="patch" \
		epatch
	fi

	# fix the makes for bsd/linux
	if [[ $CORE = fbsd ]]; then
		# Link in freebsd kernel.
		ln -s "/usr/src/sys-${K_RV}" "${WORKDIR}/sys"
		# SUBDIR variable gets to all Makefiles, we need it only in the main one.
		SUBDIRS=${VIDCARDS//.ko}
		sed -i \
			-e "s:SUBDIR\ =.*:SUBDIR\ =\ drm ${SUBDIRS}:" \
			"${SRC_BUILD}"/Makefile || die "Fixing SUBDIRS failed."
	else
		convert_to_m "${SRC_BUILD}"/Makefile
	fi
}

src_compile() {
	einfo "Building DRM in ${SRC_BUILD}..."
	src_compile_${CORE}
}

src_install() {
	cd "${SRC_BUILD}"

	src_install_${CORE}

	dodoc "${S}/linux-core/README.drm"
}

pkg_postinst() {
	if use video_cards_sis; then
		einfo "SiS direct rendering only works on 300 series chipsets."
		einfo "SiS framebuffer also needs to be enabled in the kernel."
	fi

	if use video_cards_mach64; then
		einfo "The Mach64 DRI driver is insecure."
		einfo "Malicious clients can write to system memory."
		einfo "For more information, see:"
		einfo "http://dri.freedesktop.org/wiki/ATIMach64."
	fi

	[[ ${CORE} = linux ]] && linux-mod_pkg_postinst
}

# Functions used above are defined below:

_set_build_type() {
	# here we check if we are using linux kernel or the fbsd one
	use kernel_FreeBSD && CORE="fbsd"
	use kernel_linux && CORE="linux"
	! use kernel_FreeBSD && ! use kernel_linux && die "Unsupported kernel type"
}

kernel_setup() {
	if [[ ${CORE} = fbsd ]] ; then
		K_RV=${CHOST/*-freebsd/}
	else
		CONFIG_CHECK="!DRM"
		ERROR_DRM="Please disable DRM in the kernel config. (CONFIG_DRM = n)"
		linux-mod_pkg_setup

		if kernel_is 2 4; then
			eerror "Upstream support for 2.4 kernels has been removed, so this package will no"
			eerror "longer support them."
			die "Please use in-kernel DRM or switch to a 2.6 kernel."
		fi
	fi
}

set_vidcards() {
	VIDCARDS=""

	if [[ -n "${VIDEO_CARDS}" ]]; then
		use video_cards_mach64 && \
			VIDCARDS="${VIDCARDS} mach64.${KV_OBJ}"
		use video_cards_mga && \
			VIDCARDS="${VIDCARDS} mga.${KV_OBJ}"
		use video_cards_r128 && \
			VIDCARDS="${VIDCARDS} r128.${KV_OBJ}"
		use video_cards_radeon || use video_cards_radeonhd && \
			VIDCARDS="${VIDCARDS} radeon.${KV_OBJ}"
		use video_cards_savage && \
			VIDCARDS="${VIDCARDS} savage.${KV_OBJ}"
		use video_cards_sis && \
			VIDCARDS="${VIDCARDS} sis.${KV_OBJ}"
		use video_cards_via && \
			VIDCARDS="${VIDCARDS} via.${KV_OBJ}"
		use video_cards_sunffb && \
			VIDCARDS="${VIDCARDS} ffb.${KV_OBJ}"
		use video_cards_tdfx && \
			VIDCARDS="${VIDCARDS} tdfx.${KV_OBJ}"
	fi
}

src_compile_linux() {
	# remove leading and trailing space
	VIDCARDS="${VIDCARDS% }"
	VIDCARDS="${VIDCARDS# }"

	check_modules_supported
	MODULE_NAMES=""
	for i in drm.${KV_OBJ} ${VIDCARDS}; do
		MODULE_NAMES="${MODULE_NAMES} ${i/.${KV_OBJ}}(${PN}:${SRC_BUILD})"
		i=$(echo ${i/.${KV_OBJ}} | tr '[:lower:]' '[:upper:]')
		eval MODULESD_${i}_ENABLED="yes"
	done

	# This now uses an M= build system. Makefile does most of the work.
	cd "${SRC_BUILD}"
	unset ARCH
	BUILD_TARGETS="modules"
	BUILD_PARAMS="DRM_MODULES='${VIDCARDS}' LINUXDIR='${KERNEL_DIR}' M='${SRC_BUILD}'"
	ECONF_PARAMS='' S="${SRC_BUILD}" linux-mod_src_compile
}

src_compile_fbsd() {
	cd "${SRC_BUILD}"
	# Environment CFLAGS overwrite kernel CFLAGS which is bad.
	local svcflags=${CFLAGS}; local svldflags=${LDFLAGS}
	unset CFLAGS; unset LDFLAGS
	MAKE=make \
		emake \
		NO_WERROR= \
		SYSDIR="${WORKDIR}/sys" \
		KMODDIR="/boot/modules" \
		|| die "pmake failed."
	export CFLAGS=${svcflags}; export LDFLAGS=${svldflags}
}

src_install_linux() {
	linux-mod_src_install

	# Strip binaries, leaving /lib/modules untouched (bug #24415)
	strip_bins \/lib\/modules
}

src_install_fbsd() {
	cd "${SRC_BUILD}"
	dodir "/boot/modules"
	MAKE=make \
		emake \
		install \
		NO_WERROR= \
		DESTDIR="${D}" \
		KMODDIR="/boot/modules" \
		|| die "Install failed."
}
