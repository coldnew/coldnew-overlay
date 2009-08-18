# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Reference compiler for the D programming language"
HOMEPAGE="http://www.digitalmars.com/d/"
SRC_URI="http://ftp.digitalmars.com/${PN}.${PV}.zip"

LICENSE="DMD"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE=""
EAPI="2"

RESTRICT="mirror"

DEPEND="sys-apps/findutils
	!dev-lang/dmd-bin:2
	app-arch/unzip"
RDEPEND="dev-util/dmd-common
	amd64? ( app-emulation/emul-linux-x86-compat )"
PDEPEND="app-admin/eselect-dmd"

S="${WORKDIR}/${PN}2/src"

src_unpack() {
	unpack $A
	cd dmd2
	rm -rf html osx linux windows samples README.TXT license.txt
	cd src/dmd
}

src_compile() {
# DMD
	cd "${S}/dmd"
	ln -s . mars
	make -f linux.mak || die "make failed"
# druntime
	cd "${S}/druntime/src/"
	(
		export PATH="${S}/dmd:${PATH}"
		export HOME="$(pwd)"
		make -f dmd-posix.mak
	)
}

src_install() {
# Compiler
	newbin "${S}/dmd/dmd" dmd2.bin || die "Install failed"
# druntime
	dolib.a "${S}/druntime/lib/libdruntime.a" || die "Install failed"
	dodir /usr/include/druntime
	mv "${S}/druntime/import"/* "${D}/usr/include/druntime/"
}
