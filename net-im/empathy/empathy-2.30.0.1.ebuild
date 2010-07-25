# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils gnome2 multilib autotools

UP_PV="0ubuntu3"
DESCRIPTION="Telepathy client and library using GTK+"
HOMEPAGE="http://live.gnome.org/Empathy"
SRC_URI+=" mirror://ubuntu/pool/main/e/${PN}/${PN}_${PV}-${UP_PV}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
# FIXME: Add location support once geoclue stops being idiotic with automagic deps
IUSE="indicator nautilus networkmanager spell test webkit" # map

# FIXME: libnotify & libcanberra hard deps
RDEPEND=">=dev-libs/glib-2.22.0
	>=x11-libs/gtk+-2.18.0
	>=gnome-base/gconf-2
	>=dev-libs/dbus-glib-0.51
	>=gnome-extra/evolution-data-server-1.2
	>=net-libs/telepathy-glib-0.9.2
	>=media-libs/libcanberra-0.4[gtk]
	>=x11-libs/libnotify-0.4.4
	>=gnome-base/gnome-keyring-2.22

	dev-libs/libunique
	net-libs/farsight2
	media-libs/gstreamer:0.10
	media-libs/gst-plugins-base:0.10
	net-libs/telepathy-farsight
	dev-libs/libxml2
	x11-libs/libX11
	net-voip/telepathy-connection-managers

	indicator? (
		>=dev-libs/libindicate-0.3
		net-im/indicator-messages )
	nautilus? ( >=gnome-extra/nautilus-sendto-2.28.1[-empathy] )
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	spell? (
		app-text/enchant
		app-text/iso-codes )
	webkit? ( >=net-libs/webkit-gtk-1.1.15 )"
#	Upstream says not to ship this, or use this.  It is also buggy.
#	tpl? ( >=net-im/telepathy-logger-0.1.1 )
#	map? (
#		>=media-libs/libchamplain-0.4[gtk]
#		>=media-libs/clutter-gtk-0.10:1.0 )
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.17.3
	>=dev-util/intltool-0.35.0
	>=dev-util/pkgconfig-0.16
	test? (
		sys-apps/grep
		>=dev-libs/check-0.9.4 )
	dev-libs/libxslt
	virtual/python
"
PDEPEND=">=net-im/telepathy-mission-control-5"

DOCS="CONTRIBUTORS AUTHORS ChangeLog NEWS README"

pkg_setup() {
	# Hard disable favourite_contacts and tpl, TpLogger is buggy.
	G2CONF="${G2CONF}
		--disable-maintainer-mode
		--disable-static
		--disable-location
		--disable-map
		--disable-control-center-embedding
		--disable-Werror
		--disable-favourite_contacts
		--disable-tpl
		$(use_enable debug)
		$(use_enable indicator libindicate)
		$(use_enable nautilus nautilus-sendto)
		$(use_with networkmanager connectivity nm)
		$(use_enable spell)
		$(use_enable test coding-style-checks)
		$(use_enable webkit)"
}

src_prepare() {
	gnome2_src_prepare

	# apply Ubuntu patches
	cd "${WORKDIR}"
	epatch ${PN}_${PV}-${UP_PV}.diff
	cd "${S}"
	epatch debian/patches/{11_empathy_accounts_category,20_libindicate,21_login_indicators,31_really_raise_window,32_append_notifications,36_chat_window_default_size}.patch
	die
	eautoreconf
}

src_install() {
	gnome2_src_install
	if use indicator; then
		dodir /usr/share/indicators/messages/applications
		echo "/usr/share/applications/${PN}.desktop" \
			> "${D}"/usr/share/indicators/messages/applications/${PN}
	fi
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check || die "emake check failed."
}

pkg_postinst() {
	gnome2_pkg_postinst
	echo
	elog "Empathy needs telepathy's connection managers to use any IM protocol."
	elog "See the USE flags on net-voip/telepathy-connection-managers"
	elog "to install them."
}
