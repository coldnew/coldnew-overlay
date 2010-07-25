# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="The GNOME panel"
HOMEPAGE="http://www.gnome.org/"
SRC_URI+=" mirror://ubuntu/pool/main/g/${PN}/${PN}_${PV}-0ubuntu1.diff.gz"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc eds initial-animation networkmanager policykit"

RDEPEND="dev-lang/python
	>=gnome-base/gnome-desktop-2.26.0
	>=x11-libs/pango-1.15.4
	>=dev-libs/glib-2.18.0
	>=x11-libs/gtk+-2.19.7
	>=dev-libs/libgweather-2.27.90
	dev-libs/libxml2
	>=gnome-base/libgnome-2.13
	>=gnome-base/libgnomeui-2.5.4
	>=gnome-base/libbonoboui-2.1.1
	>=gnome-base/orbit-2.4
	>=x11-libs/libwnck-2.19.5
	>=gnome-base/gconf-2.6.1
	>=gnome-base/gnome-menus-2.27.92
	>=gnome-base/libbonobo-2.20.4
	gnome-base/librsvg
	>=dev-libs/dbus-glib-0.71
	>=sys-apps/dbus-1.1.2
	>=x11-libs/cairo-1
	x11-libs/libXau
	>=x11-libs/libXrandr-1.2
	eds? ( >=gnome-extra/evolution-data-server-1.6 )
	networkmanager? ( >=net-misc/networkmanager-0.6 )
	policykit? ( >=sys-auth/polkit-0.91 )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	gnome-base/gnome-common
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40
	~app-text/docbook-xml-dtd-4.1.2
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1 )"

RESTRICT="mirror"
DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-scrollkeeper
		--disable-schemas-install
		--with-in-process-applets=clock,notification-area,wncklet
		$(use_enable initial-animation)
		$(use_enable policykit polkit)
		$(use_enable networkmanager network-manager)
		$(use_enable eds)"
}

src_prepare() {
	gnome2_src_prepare

	# apply Ubuntu patches
	cd "${WORKDIR}"
	epatch ${PN}_${PV}-0ubuntu1.diff
	cd "${S}"
	epatch debian/patches/{03_dnd_places_link,04_default_panel_config,05_no_session_delay,25_dynamic_fusa_detection,30_disable-initial-animation}.patch

	# FIXME: tarball generated with broken gtk-doc, revisit me.
	if use doc; then
		sed "/^TARGET_DIR/i \GTKDOC_REBASE=/usr/bin/gtkdoc-rebase" \
			-i gtk-doc.make || die "sed 1 failed"
	else
		sed "/^TARGET_DIR/i \GTKDOC_REBASE=$(type -P true)" \
			-i gtk-doc.make || die "sed 2 failed"
	fi

	# Make it libtool-1 compatible, bug #271652
	rm -v m4/lt* m4/libtool.m4 || die "removing libtool macros failed"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

pkg_postinst() {
	local entries="${ROOT}etc/gconf/schemas/panel-default-setup.entries"
	local gconftool="${ROOT}usr/bin/gconftool-2"

	if [ -e "$entries" ]; then
		einfo "setting panel gconf defaults..."

		GCONF_CONFIG_SOURCE="$("${gconftool}" --get-default-source | sed "s;:/;:${ROOT};")"

		"${gconftool}" --direct --config-source \
			"${GCONF_CONFIG_SOURCE}" --load="${entries}"
	fi

	# Calling this late so it doesn't process the GConf schemas file we already
	# took care of.
	gnome2_pkg_postinst
}
