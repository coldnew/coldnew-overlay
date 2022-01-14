# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit git-r3

DESCRIPTION="Eselect module to maintain vala compiler symlink"
HOMEPAGE="https://github.com/coldnew/eselect-vala"

EGIT_REPO_URI="https://github.com/coldnew/eselect-vala"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-admin/eselect
	dev-lang/vala"
DEPEND="${RDEPEND}
	sys-devel/m4"

DOCS="AUTHORS README"

src_install() {
	emake DESTDIR="${D}" install
	dodoc ${DOCS}
}
