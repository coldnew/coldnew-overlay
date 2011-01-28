# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="A new Lisp dialect"
HOMEPAGE="http://www.newlisp.org"
SRC_URI="mirror://sourceforge/newlisp/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
# please keep sorted
KEYWORDS="~amd64 ~x86"
IUSE="tk"

DEPEND="sys-libs/readline
tk? ( dev-lang/tk )"

src_compile() {
	emake -j1 || die "emake failed"
	}


src_install() {

		dobin newlisp newlisp-tk/newlisp-tk.tcl examples/newlispdoc
		doman doc/newlisp.1 doc/newlisp-tk.1 doc/newlispdoc.1
		dodoc doc/CREDITS
		dohtml doc/*.html
# Install modules
dodir /usr/share/${PN}
insinto /usr/share/${PN}
doins modules/*.lsp
# Install examples
dodir /usr/share/${PN}/examples
insinto /usr/share/${PN}/examples
doins init.lsp.example examples/*
# Install tk stuff
dodir /usr/share/${PN}/newlisp-tk
insinto /usr/share/${PN}/newlisp-tk
doins newlisp-tk/*.lsp
dodir /usr/share/${PN}/newlisp-tk/images
insinto /usr/share/${PN}/newlisp-tk/images
doins newlisp-tk/images/*

}


