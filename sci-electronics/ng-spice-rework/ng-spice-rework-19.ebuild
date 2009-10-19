# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/ng-spice-rework/ng-spice-rework-18.ebuild,v 1.1 2008/12/10 16:27:25 calchan Exp $

inherit eutils autotools

DESCRIPTION="The Next Generation Spice (Electronic Circuit Simulator)."
SRC_URI="mirror://sourceforge/ngspice/${P}.tar.gz
	doc? ( http://users.ece.gatech.edu/~mrichard/Xspice/Xspice_Users_Manual.pdf \
		http://users.ece.gatech.edu/~mrichard/Xspice/XSpice_SoftwareDesignDoc_Sep92.pdf \
		http://users.ece.gatech.edu/~mrichard/Xspice/XSpice_InterfaceDesignDoc_Sep92.pdf \
		http://users.ece.gatech.edu/~mrichard/Xspice/XSpice_CodeModelSubsysSoftwareDesign.pdf \
		http://users.ece.gatech.edu/~mrichard/Xspice/XSpice_CodeModelSubsysInterfaceDesign.pdf )"
HOMEPAGE="http://ngspice.sourceforge.net"
LICENSE="BSD GPL-2"

SLOT="0"
IUSE="X debug doc readline"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="readline? ( >=sys-libs/readline-5.0 )
	X? ( x11-libs/libXaw
		x11-libs/libXt
		x11-libs/libX11
		sci-visualization/xgraph )"
S=${WORKDIR}/ngspice-19
src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -rf xgraph
	#epatch "${FILESDIR}"/${PN}-postscript.patch
	#epatch "${FILESDIR}"/${P}-src_makefile.patch
	sed -i -e 's/\-O2//' configure.in || die "sed failed"
	if use doc ; then
		cp "${DISTDIR}"/Xspice_Users_Manual.pdf "${S}"
		cp "${DISTDIR}"/XSpice_SoftwareDesignDoc_Sep92.pdf "${S}"
		cp "${DISTDIR}"/XSpice_InterfaceDesignDoc_Sep92.pdf "${S}"
		cp "${DISTDIR}"/XSpice_CodeModelSubsysSoftwareDesign.pdf "${S}"
		cp "${DISTDIR}"/XSpice_CodeModelSubsysInterfaceDesign.pdf "${S}"
	fi
	eautoreconf
}

src_compile() {
	local MYCONF
	if use debug ; then
		MYCONF="--enable-debug \
			--enable-ftedebug \
			--enable-cpdebug \
			--enable-asdebug \
			--enable-stepdebug \
			--enable-pzdebug"
	else
		MYCONF="--disable-debug \
			--disable-ftedebug \
			--disable-cpdebug \
			--disable-asdebug \
			--disable-stepdebug \
			--disable-pzdebug"
	fi
	# Those don't compile
	MYCONF="${MYCONF} \
		--disable-sensdebug \
		--disable-blktmsdebug \
		--disable-smltmsdebug"

	econf ${MYCONF} \
		--enable-intnoise \
		--enable-xspice \
		--enable-numparam \
		--enable-dot-global \
		--disable-xgraph \
		--disable-dependency-tracking \
		$(use_with X x) \
		$(use_with readline) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	local infoFile
	for infoFile in doc/ngspice.info*; do
		echo 'INFO-DIR-SECTION EDA' >> ${infoFile}
		echo 'START-INFO-DIR-ENTRY' >> ${infoFile}
		echo '* NGSPICE: (ngspice). Electronic Circuit Simulator.' >> ${infoFile}
		echo 'END-INFO-DIR-ENTRY' >> ${infoFile}
	done

	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ANALYSES AUTHORS BUGS ChangeLog DEVICES NEWS \
		README Stuarts_Poly_Notes || die "failed to install documentation"

	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins doc/ngspice.pdf
		doins *.pdf
	fi

	# We don't need makeidx to be installed
	rm "${D}"/usr/bin/makeidx
}

src_test () {
	# Bug 108405
	true
}
