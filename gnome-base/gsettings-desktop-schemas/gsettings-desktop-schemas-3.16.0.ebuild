# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Collection of GSettings schemas for GNOME desktop"
HOMEPAGE="https://git.gnome.org/browse/gsettings-desktop-schemas"

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="+introspection"
KEYWORDS="*"

RDEPEND="
	>=dev-libs/glib-2.42.0:2
	introspection? ( >=dev-libs/gobject-introspection-1.42.0 )
	!<gnome-base/gdm-3.8
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	DOCS="AUTHORS HACKING NEWS README"
	gnome2_src_configure $(use_enable introspection)
}
