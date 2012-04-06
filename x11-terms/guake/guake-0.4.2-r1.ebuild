# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/guake/guake-0.4.2-r1.ebuild,v 1.1 2012/03/14 03:31:00 floppym Exp $

EAPI=3

GCONF_DEBUG=no
PYTHON_DEPEND="2:2.7"

inherit eutils gnome2 python multilib

DESCRIPTION="A dropdown terminal made for the GNOME desktop"
HOMEPAGE="http://guake.org/"
SRC_URI="mirror://debian/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"
#SRC_URI="http://guake.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.10:2
	dev-python/pygtk
	x11-libs/vte:0[python]
	dev-python/notify-python
	dev-python/gconf-python
	dev-python/dbus-python
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="--disable-static
		--disable-dependency-tracking
		$(use_enable nls)"
	python_set_active_version 2
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-int-ssl-port.patch \
		"${FILESDIR}"/${P}-prefs-spinbox.patch

	sed -i -e s:/usr/bin/python:/usr/bin/python2: src/guake*.in || die

	gnome2_src_prepare
	# Fix build with newer glib due to G_DISABLE_SINGLE_INCLUDES
	grep -lre '<glib/gtypes.h>' "${S}" | while read i; do
	sed -ie 's:glib/gtypes.h:glib.h:' "${i}" || die "Unable to sed \"$i\""
	done

}

src_install() {
	gnome2_src_install
	find "${D}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize /usr/$(get_libdir)/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
