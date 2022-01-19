# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit meson vala

DESCRIPTION="LSP server for vala"
HOMEPAGE="https://github.com/Prince781/vala-language-server"
SRC_URI="https://github.com/Prince781/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+plugins"

DEPEND="
	>=dev-lang/vala-0.48.12
	>=dev-libs/libgee-0.8
	>=dev-libs/json-glib-1.0
	>=dev-libs/jsonrpc-glib-3.28
"
RDEPEND="
	${DEPEND}
	plugins? ( >=dev-util/gnome-builder-3.35 )
	"
BDEPEND="
	virtual/pkgconfig
	$(vala_depend)
"

src_prepare() {
	vala_src_prepare
	eapply_user
}

src_configure() {
	local emesonargs=(
		$(meson_use plugins)
	)
	meson_src_configure
}
