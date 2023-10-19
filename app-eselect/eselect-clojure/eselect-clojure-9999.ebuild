# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

inherit git-r3

DESCRIPTION="Eselect module to maintain clojure symlink"
HOMEPAGE="https://github.com/coldnew/eselect-clojure"

EGIT_REPO_URI="https://github.com/coldnew/eselect-clojure"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-admin/eselect
	dev-lang/clojure"
DEPEND="${RDEPEND}
	sys-devel/m4"

DOCS="AUTHORS README"

src_install() {
	emake DESTDIR="${D}" install
}
