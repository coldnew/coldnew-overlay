# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
GCONF_DEBUG="no"

inherit gnome2 versionator

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="Canonical's on-screen-display notification agent"
HOMEPAGE="https://launchpad.net/notify-osd"
SRC_URI="http://launchpad.net/notify-osd/${MY_PV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16
	gnome-base/gconf:2
	>=dev-libs/dbus-glib-0.76
	>=x11-libs/gtk+-2.14
	>=x11-libs/libnotify-0.4.5
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/intltool
	!x11-misc/notification-daemon
	!x11-misc/xfce4-notifyd"

DOCS="AUTHORS ChangeLog NEWS README TODO"
