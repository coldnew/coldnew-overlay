# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A small applet to display information from various applications consistently in the panel"
HOMEPAGE="https://launchpad.net/indicator-applet/"
SRC_URI="mirror://ubuntu/pool/main/i/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.12:2
	gnome-extra/indicator-applet"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

RESTRICT="mirror"

DOCS="AUTHORS ChangeLog COPYING README"
