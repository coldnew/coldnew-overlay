# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils elisp-common

DESCRIPTION="The most intelligent development tools for C/C++"
HOMEPAGE="http://cx4a.org/software/gccsense/index.html"
SRC_URI="http://cx4a.org/pub/gccsense/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86-fbsd"
IUSE="emacs"

DEPEND="emacs? ( virtual/emacs )"
RDEPEND="=dev-util/gcc-code-assist-${PV}
	dev-lang/ruby
	dev-ruby/rubygems
	dev-ruby/sqlite3-ruby"

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	epatch "${FILESDIR}"/${P}-elisp.patch
}

src_compile() {
	if use emacs ; then
		elisp-compile etc/gccsense.el \
			|| die "emacs module failed"
	fi
}

src_install() {
	dobin bin/*

	if use emacs ; then
		elisp-install ${PN} etc/gccsense.{el,elc} || die
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}
