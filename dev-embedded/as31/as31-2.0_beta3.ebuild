# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="AS31 is a free 8051 assembler."
HOMEPAGE="http://www.pjrc.com/tech/8051/"
SRC_URI="http://www.pjrc.com/tech/8051/tools/as31_beta3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	emake || die "emake failed"
}

src_test() {
	cd "${S}/tests"
	../as31 paulmon1.asm
	../as31 paulmon2.asm 
	../as31 extra.asm
	diff -q paulmon1.hex paulmon1.ref || die "test failed"
	diff -q paulmon2.hex paulmon2.ref || die "test failed"
	diff -q extra.hex extra.ref || die "test failed"
}

src_install() {
	exeinto /usr/bin
	doexe as31 as31_gtk || die "doexe failed"
	
	dodoc README
}
