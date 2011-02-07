# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.3-r1.ebuild,v 1.6 2006/05/24 20:15:44 hansmi Exp $

inherit autotools cvs eutils

MY_P="${PN}"
DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
HOMEPAGE="http://incrtcl.sourceforge.net/"
SRC_URI=""

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

DEPEND="dev-lang/tcl"

S="${WORKDIR}/incrTcl"

src_unpack() {
	ECVS_SERVER="incrtcl.cvs.sourceforge.net:/cvsroot/incrtcl"
	ECVS_USER="anonymous"
	ECVS_PASS=""
	ECVS_AUTH="pserver"
	ECVS_MODULE="incrTcl"
	ECVS_TOP_DIR="${DISTDIR}/cvs-src/${ECVS_MODULE}"
	cvs_src_unpack
	cd ${S}
	sed -i -e "s/relid'/relid/" configure || die
	eaclocal
	eautoconf
}

src_compile() {
	econf || die "econf failed"
	emake CFLAGS_DEFAULT="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES ChangeLog INCOMPATIBLE README TODO
}
