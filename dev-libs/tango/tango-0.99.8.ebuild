# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mercurial subversion eutils

DESCRIPTION="Tango is a cross-platform open-source software library for D programmers."

HOMEPAGE="http://www.digitalmars.com"
ESVN_REPO_URI="http://svn.dsource.org/projects/tango/tags/releases/0.99.8"
ESVN_OFFLINE="1"

IUSE="dmd ldc"
EAPI="2"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
SLOT="0"

RDEPEND="ldc? ( =dev-lang/ldc-0.9.1 )
		dmd? ( =dev-lang/dmd-1.041 )"

DEPEND="${RDEPEND}
		dmd? ( =dev-libs/phobos-1.041 )"

LICENSE="GPL-2"

S="${WORKDIR}/tango"

pkg_setup() {
	if ! use dmd && ! use ldc ; then
		eerror ""
		eerror "I didn't find nor ldc nor dmd in USE."
		eerror "You must select at least one compiler"
		eerror "for which to build the library."
	fi
}

src_compile() {
	cd lib

	(cd ../tango
	epatch "${FILESDIR}/tango-0.99.8-dmd.patch")
	if use dmd ; then
		echo "#!/bin/bash" > "${T}/dmd"
		echo "dmd1.bin -L-L/usr/lib -I/usr/include/d \$*" >> "${T}/dmd"
		chmod u+x "${T}/dmd"
		export PATH="${T}:${PATH}"
		./build-dmd.sh || die "Failed to build tango runtime for dmd"
		./build-tango.sh --verbose dmd || die "Failed to build tango user lib for dmd"
	fi

	if use ldc ; then
		(cd ..
		epatch "${FILESDIR}/tango-0.99.8-ldc.patch")
		./build-tango.sh --verbose ldc || die "Failed to build tango user lib for ldc"
	fi
}

src_install() {
	dolib.a lib/*.a

	dodir /usr/include/tango/
	cp -r tango "${D}/usr/include/tango" || die "install failed"
	cp -r	std			"${D}/usr/include/tango" || die "install failed"
	cp object.di "${D}/usr/include/tango" || die "install failed"

	if use dmd; then
		dobin "${FILESDIR}/dmd.dmd1-tango"
	fi
}

