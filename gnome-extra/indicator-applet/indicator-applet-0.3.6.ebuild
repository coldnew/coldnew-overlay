# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="GNOME panel indicator applet"
HOMEPAGE="http://launchpad.net/indicator-applet/"
SRC_URI="mirror://ubuntu/pool/main/i/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.12:2
	>=dev-libs/dbus-glib-0.76
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-2
	!gnome-extra/fast-user-switch-applet
	>=dev-libs/libindicator-0.3.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

RESTRICT="mirror"

pkg_setup() {
	G2CONF="$(use_enable nls)
		--disable-dependency-tracking"
	DOCS="AUTHORS"
}
