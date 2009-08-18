# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI="2"

DESCRIPTION="The Phobos standard library for DMD"
HOMEPAGE="http://www.digitalmars.com/d/"
SRC_URI="http://ftp.digitalmars.com/dmd.${PV}.zip"

LICENSE="DMD"
RESTRICT="mirror strip binchecks"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE=""
EAPI="2"

DEPEND="=dev-lang/dmd-${PV}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/dmd2/src"

src_unpack() {
	unpack $A
	cd dmd2
	rm -rf html osx lib linux windows samples README.TXT license.txt
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
# Phobos
	mkdir -p "${WORKDIR}/dmd/src/lib"
	cd "${S}/phobos"
	echo '#!/bin/sh' > dmd
	echo '/usr/bin/dmd2.bin -I/usr/include/druntime $*' >> dmd
	chmod u+x dmd
	export PATH=.:$PATH
	make -f linux.mak || die "make failed"
# clean up
	find . -name "*.asm" -print0 | xargs -0 rm -v
	find . -name "*.mak" -print0 | xargs -0 rm -v
	find . -name "*.txt" -print0 | xargs -0 rm -v
	find . -name "*.ddoc" -print0 | xargs -0 rm -v
	find . -name "*.c" -print0 | xargs -0 rm -v
}

src_install() {
# lib
	dolib.a "${WORKDIR}/dmd2/src/phobos/obj/posix/release/libphobos2.a" || die "Install failed"

# includes
	rm -rf "${S}/phobos/obj"
	dodir /usr/include/phobos2
	mv "${S}/phobos"/* "${D}/usr/include/phobos2/"

# Config
	dobin "${FILESDIR}/dmd.dmd2-phobos"
}

