# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="Retroshare is an encrypted IM with filesharing, mediaplayer, email, chatgroups and some games."
HOMEPAGE="http://retroshare.sf.net/"
SRC_URI="mirror://sourceforge/retroshare/retroshare-pkg-linux-src-v${PV}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"
RESTRICT="strip"
DEPEND="sys-libs/zlib \
	!dedicated?  ( >=x11-libs/qt-4.2.2
			media-libs/freetype \
			x11-libs/libXinerama \
			dev-libs/libxml2 \
			x11-libs/libXft \
			x11-libs/libXdmcp \
			x11-libs/libX11 \
			x11-libs/libXrender \
			dev-libs/expat \
			x11-libs/libXau \
			x11-libs/libXext  ) "
RDEPEND="${DEPEND}"

#versions of packages
RETROSHARE="v${PV}"
OPENSSL="openssl-0.9.7g-xpgp-0.1c"
MINIUPNPC="miniupnpc-1.0"
QCHECKERS="qcheckers-svn14"
SMPLAYER="smplayer-svn-280308"

#directories used in the ebuild:
S="${WORKDIR}/retroshare-package-${RETROSHARE}"
OPENSSL_DIR="${S}/src/${OPENSSL}"
MINIUPNPC_DIR="${S}/src/${MINIUPNPC}"
QCHECKERS_DIR="${S}/src/${QCHECKERS}"
SMPLAYER_DIR="${S}/src/smplayer"
RS_CORE_DIR="${S}/src/retroshare-${RETROSHARE}/libretroshare/src"
RS_GUI_DIR="${S}/src/retroshare-${RETROSHARE}/retroshare-gui/src"

src_unpack() {
	unpack ${A}
	mkdir "${S}/src"
	cd "${S}/src"
	tar xfz "${S}/tar/${OPENSSL}.tgz"
	tar xfz "${S}/tar/${MINIUPNPC}-RSa.tar.gz"
	tar xfz "${S}/tar/${QCHECKERS}.tgz"
	tar xfz "${S}/tar/${SMPLAYER}.tgz"
	tar xfz "${S}/tar/retroshare-${RETROSHARE}-src.tgz"

	einfo "Patching Openssl dir"
	#this assumes config chooses linux-elf.
	cd ${OPENSSL_DIR}
	sed -i "s|-O3 -fomit-frame-pointer -m486|${CFLAGS}|" Configure || die "sed failed"

	einfo "Patching Miniupnpc"
	sed -i "s|CFLAGS = -O -Wall -DDEBUG|CFLAGS = ${CFLAGS} -Wall|" ${MINIUPNPC_DIR}/Makefile || die "Patching miniupnpc failed"

	einfo "Patching Retroshare dir"
	cd ${RS_CORE_DIR}
	sed -i "s|-Wall -g|${CFLAGS} -Wall|" make.opt || die "sed CFLAGS failed"
	sed -i "s|-Wall -g|${CFLAGS} -Wall|" scripts/config-linux.mk || die "patching makefile failed"
	sed -i "s|-O3 -fomit-frame-pointer -m486|${CFLAGS}|" scripts/config-linux.mk || die "patching makefile failed"
	# due to qmake generating makefiles, some patching is done later on :/
}

src_compile() {
	#we need this dir for the collection of libs:
	mkdir "${S}/lib"

	einfo build openssl
	cd ${OPENSSL_DIR}
	#Usage: Configure [no-<cipher> ...] [-Dxxx] [-lxxx] [-Lxxx] [-fxxx] [-Kxxx] [no-engine] [no-hw-xxx|no-hw]
	#		[[no-]threads] [[no-]shared] [[no-]zlib|zlib-dynamic] [no-asm] [no-dso] [no-krb5] [386]
	#		[[no-]fips] [debug] [--prefix=DIR] [--openssldir=OPENSSLDIR] [--with-xxx[=vvv]]
	#		[--test-sanity] os/compiler[:flags]
	./config || die "OpenSSL config failed"
	emake depend || die "make depend failed for SSL"
	emake || die "Emake failed for SSL"
	cp libcrypto.a libssl.a "${S}/lib"

	einfo build miniupnpc
	cd "${MINIUPNPC_DIR}"
	echo ${MINIUPNPC_DIR}
	make || die "Miniupnc make failed"
	cp libminiupnpc.a "${S}/lib"

	einfo build RetroShare Core
	cd ${RS_CORE_DIR}
	# Makefiles buggy!
	emake -j1 || die "emake of retroshare failed"
	cp lib/libretroshare.a "${S}/lib"

	if use !dedicated ; then
		einfo build qcheckers
		cd ${QCHECKERS_DIR}
		qmake || die "qmake qcheckers failed"
		cd src
		qmake || die "qmake qcheckers failed"
		sed -i "s|CFLAGS        =.*|CFLAGS        = ${CFLAGS} -fPIC -Wall -W -D_REENTRANT \$(DEFINES)|" Makefile
		sed -i "s|CXXFLAGS      =.*|CXXFLAGS      = ${CXXFLAGS} -fPIC -Wall -W -D_REENTRANT $(DEFINES)|" Makefile
		cd ..
		emake || die "make qcheckers failed"
		cp src/libqcheckers.a "${S}/lib"

		einfo build libsmplayer
		cd ${SMPLAYER_DIR}
		qmake || die "qmake smplayer failed"
		sed -i "s|CFLAGS        =.*|CFLAGS        = ${CFLAGS} -fPIC -Wall -W -D_REENTRANT \$(DEFINES)|" Makefile
		sed -i "s|CXXFLAGS      =.*|CXXFLAGS      = ${CXXFLAGS} -fPIC -Wall -W -D_REENTRANT $(DEFINES)|" Makefile
		emake || die "make smplayer failed"
		cp lib/libsmplayer.a "${S}/lib"

		einfo build RetroShare Qt GUI
		cd "${RS_GUI_DIR}"
		qmake RetroShare.pro || die "qmake failed for qtgui"
		sed -i "s|CFLAGS        =.*|CFLAGS        = ${CFLAGS} -D_REENTRANT -Wall -W \$(DEFINES)|" Makefile || die
		sed -i "s|CXXFLAGS      =.*|CXXFLAGS      = ${CXXFLAGS} -D_REENTRANT -Wall -W \$(DEFINES)|" Makefile || die
		sed -i "s:-L/usr/lib -L../../../../lib:-L../../../../lib -L/usr/lib:" Makefile || die
		emake || die "emake of qtgui failed"
	fi
}

src_install() {
	cd "${RS_CORE_DIR}/rsiface"
	dobin retroshare-nogui
	einfo retroshare-nogui installed to /usr/bin/retroshare-nogui

	if use !dedicated; then
		cd "${RS_GUI_DIR}"
		dobin RetroShare

		#installing the logo
		#insinto /usr/share/icons/hicolor/16x16/apps/
		#doins gui/images/RetroShare16.png

		einfo type RetroShare to start the gui
	else
		cd ${MINIUPNPC_DIR}
		cp libminiupnpc.so libminiupnpc.so.2
		dolib libminiupnpc.so.2
		einfo "Non-Gui executables can be found in /usr/bin amd is called retroshare-nogui"
	fi
}
