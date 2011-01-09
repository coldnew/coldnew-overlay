# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils python distutils subversion flag-o-matic

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/@242"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cuda opencl"

DEPEND="!<app-crypt/pyrit-0.3-r1
	dev-db/sqlite:3
	dev-lang/python[sqlite]
	net-analyzer/scapy
	opencl? (  ~app-crypt/cpyrit_opencl-0.3 )
	cuda? (  ~app-crypt/cpyrit_cuda-0.3 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	append-ldflags $(no-as-needed)
}

src_compile() {
	cd "${S}/pyrit"
	distutils_src_compile
}

src_install() {
	cd "${S}/pyrit"
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/{pyrit_cli.py,cpyrit}
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/{pyrit_cli.py,cpyrit}
}
