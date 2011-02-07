# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit gnome2 eutils

DESCRIPTION="Zeitgeist Client Library"
HOMEPAGE="https://launchpad.net/libzeitgeist"
SRC_URI="http://launchpad.net/libzeitgeist/0.2/0.2.14/+download/libzeitgeist-0.2.14.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.15"
DEPEND="${RDEPEND}
>=dev-util/pkgconfig-0.9"

pkg_setup() {
	G2CONF="${G2CONF}
	--enable-module=no"
}
