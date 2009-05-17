# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="cbmbasic - Commodore BASIC V2 as a scripting language"
HOMEPAGE="http://www.pagetable.com/?p=48"
SRC_URI="http://www.weihenstephan.org/~michaste/pagetable/recompiler/cbmbasic.zip"

LICENSE="GPL-COMPATIBLE"
SLOT="0"
KEYWORDS="amd64 x86 sparc"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake
}

src_install() {
	dobin cbmbasic
	dodoc README.txt
}
