# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git autotools

EAPI=3

DESCRIPTION="Verilator is the fastest free Verilog HDL simulator, and beats many commercial simulators. "
HOMEPAGE="http://www.veripool.org/wiki/verilator"
SRC_URI=""
EGIT_REPO_URI="http://git.veripool.org/git/verilator"


LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-devel/flex
        sys-devel/bison"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}

src_configure() {
	eautoconf
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
}

