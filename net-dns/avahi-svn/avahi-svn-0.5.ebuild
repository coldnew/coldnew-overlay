# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt3 subversion mono python

ESVN_REPO_URI="svn://svn.0pointer.de/avahi/trunk/"
ESVN_PROJECT="avahi"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

DESCRIPTION="System which facilitates service discovery on a local network"
HOMEPAGE="http://www.freedesktop.org/Software/Avahi"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus doc gtk mono python qt"

RDEPEND="!net-dns/avahi
	dev-libs/libdaemon
	dev-libs/expat
	qt? ( $(qt_min_version 3.3) )
	gtk? (
		>=x11-libs/gtk+-2
		>=gnome-base/libglade-2
		>=dev-libs/glib-2
	)
	mono? ( dev-lang/mono )
	python? (
		>=virtual/python-2.4
		dbus? (
			>=sys-apps/dbus-0.30
		)
		gtk? (
			>=dev-python/pygtk-2
		)
	)"
DEPEND="${RDEPEND}
	app-doc/xmltoman
	doc? (
		app-doc/doxygen
		mono? ( >=dev-util/monodoc-1.1.8 )
	)"

export PKG_CONFIG_PATH="${QTDIR}/lib/pkgconfig"

pkg_setup() {
	enewgroup avahi
	enewuser avahi -1 -1 -1 avahi
}

src_compile() {
	local myconf=""

	if use python
	then
		if use dbus
		then
			myconf="${myconf} --enable-python-dbus"
		fi

		if use gtk
		then
			myconf="${myconf} --enable-pygtk"
		fi
	fi

	if use mono && use doc
	then
		myconf="${myconf} --enable-monodoc"
	fi

	econf \
		--localstatedir=/var \
		--with-distro=gentoo \
		--disable-qt4 \
		--disable-monodoc \
		--disable-python-dbus \
		--disable-pygtk \
		$(use_enable python) \
		$(use_enable mono) \
		$(use_enable doc doxygen-doc) \
		$(use_enable dbus) \
		$(use_enable gtk) \
		$(use_enable qt qt3) \
		$(use_enable gtk glib) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	dodoc docs/{AUTHORS,README,TODO}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/lib/python*/site-packages/avahi
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/lib/python*/site-packages/avahi
}
