# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.17.3.ebuild,v 1.1 2009/03/08 20:06:34 truedfx Exp $

inherit eutils multilib elisp-common

DESCRIPTION="Shared library implementing a Lisp dialect"
HOMEPAGE="http://librep.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="emacs readline"

RDEPEND=">=sys-libs/gdbm-1.8.0
	emacs? ( virtual/emacs )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	sys-apps/texinfo"

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
}

src_compile() {
	econf \
		--libexecdir=/usr/$(get_libdir) \
		--without-gmp \
		--without-ffi \
		$(use_with readline) || die "configure failed"

	emake || die "make failed"

	if use emacs; then
		elisp-compile rep-debugger.el || die "elisp-compile failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO TREE
	docinto doc
	dodoc doc/*

	if use emacs; then
		elisp-install ${PN} rep-debugger.{el,elc} || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/50${PN}-gentoo.el" \
			|| die "elisp-site-file-install failed"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
