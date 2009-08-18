# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${P/-common/}
MY_P=${MY_P/-/.}

DESCRIPTION="Common tools and docs for Digtal Mars compilers"
HOMEPAGE="http://www.digitalmars.com/d/"
SRC_URI="http://ftp.digitalmars.com/${MY_P}.zip"

LICENSE="DMD"
RESTRICT="mirror strip"
SLOT="2"
KEYWORDS="~x86 ~amd64"

IUSE=""

S="${WORKDIR}"

DEPEND="sys-apps/findutils"
RDEPEND="amd64? ( app-emulation/emul-linux-x86-compat )"

src_unpack() {
	unpack ${A}

	cd dmd/linux/bin

	rm *.TXT *.conf

	# Fix permissions
	fperms guo=r `find . -type f`
	fperms guo=rx `find . -type d`
	fperms guo=rx dumpobj obj2asm rdmd

	rm dmd
}

src_install() {
	cd "${S}/dmd"

	# Man pages
	doman man/man1/dmd.1
	doman man/man1/dmd.conf.5
	doman man/man1/dumpobj.1
	doman man/man1/obj2asm.1
	doman man/man1/rdmd.1
	rm -r man

	# Tools
	dobin linux/bin/*
}
