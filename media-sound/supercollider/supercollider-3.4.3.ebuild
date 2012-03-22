# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit elisp-common toolchain-funcs scons-utils

DESCRIPTION="An environment and a programming language for real time audio synthesis."
HOMEPAGE="http://www.audiosynth.com http://supercollider.sourceforge.net"

MY_PN="SuperCollider"
MY_P="${MY_PN}-${PV}"

SRC_URI="mirror://sourceforge/${PN}/Source/${PV}/${MY_P}-Source-linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

# lid means linux input device support.
IUSE="alsa altivec curl debug devel emacs fftw gedit jack lang lid portaudio readline rendezvous sse sse2 strip vim wii X"

RDEPEND=">=media-sound/jack-audio-connection-kit-0.100.0
	media-libs/alsa-lib
	>=media-libs/libsndfile-1.0.16
	fftw? ( >=sci-libs/fftw-3.0 )
	readline? ( >=sys-libs/readline-5.0 )
	portaudio? ( media-libs/portaudio )"

DEPEND="${RDEPEND}
	sys-apps/sed
	sys-devel/automake
	dev-util/scons
	emacs? ( virtual/emacs )
	lang? ( dev-libs/icu )
	dev-util/pkgconfig
	dev-util/scons
	gedit? ( app-editors/gedit )
	vim? ( app-editors/vim )"

S="${WORKDIR}/${MY_PN}-Source/common"

#src_prepare() {
	# Uncommenting a line per linux/examples/sclang.cfg.in
#	if ! use emacs; then
#		sed -ie "/#-@SC_LIB_DIR@\/Common\/GUI\/Document.sc/s/^#//" \
#			"${S}/linux/examples/sclang.cfg.in" ||
#			die "sed failed."
#	else
#		sed -e "/elisp_dir = os.path.join(INSTALL_PREFIX/s/site-lisp')/site-lisp','scel')/" \
#		-i "${S}/SConstruct" ||
#		die "modifying elisp installdir failed."
#	fi

	# remove strange rpath
#	sed -e "/LINKFLAGS = /s/'-Wl,-rpath,build -Wl/'-Wl, -rpath -Wl/" -i "${S}/SConstruct" ||
#		die "fix rpath failed."
#}

src_compile() {
	tc-export CC CXX
	mkdir -p "${D}"

	escons CUSTOMCCFLAGS="${CFLAGS}" CUSTOMCXXFLAGS="${CXXFLAGS}" \
		PREFIX="/usr" DESTDIR="${D}" \
		$(use_scons alsa ALSA) $(use_scons altivec ALTIVEC) $(use_scons curl CURL) \
		$(use_scons jack AUDIOAPI jack) $(use_scons readline READLINE) \
		$(use_scons debug DEBUG) $(use_scons devel DEVELOPMENT) $(use_scons fftw FFTW) \
		$(use_scons lang LANG) $(use_scons lid LID) $(use_scons wii WII) \
		$(use_scons rendezvous RENDEZVOUS) $(use_scons emacs SCEL) $(use_scons vim SCVIM) \
		$(use_scons gedit SCED) $(use_scons sse SSE) $(use_scons sse2 SSE2) \
		$(use_scons X X11) $(use_scons strip STRIP) || die "compilation failed"
}

src_install() {
	# Main install
	escons install || die "instal failed"

	# Install our config file
	insinto /etc/supercollider
	doins linux/examples/sclang.cfg

	# Documentation
	mv "README LINUX" "README-linux"
	mv editors/scel/README editors/scel/README-scel
	dodoc README-linux editors/scel/README-scel

	# Our documentation
	sed -e "s:@DOCBASE@:/usr/share/doc/${PF}:" < "${FILESDIR}/README-gentoo.txt" | gzip > "${D}/usr/share/doc/${PF}/README-gentoo.txt.gz"

	# Example files (don't gzip)
	insinto /usr/share/doc/${PF}/examples
	doins linux/examples/onetwoonetwo.sc linux/examples/sclang.sc

	use emacs && elisp-site-file-install "${FILESDIR}/70scel-gentoo.el"
}

pkg_postinst() {
	einfo
	einfo "Notice: SuperCollider is not very intuitive to get up and running."
	einfo "The best course of action to make sure that the installation was"
	einfo "successful and get you started with using SuperCollider is to take"
	einfo "a look through /usr/share/doc/${PF}/README-gentoo.txt.gz"
	einfo
}
