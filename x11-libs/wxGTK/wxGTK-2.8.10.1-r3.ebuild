# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.8.10.1-r2.ebuild,v 1.1 2009/07/21 20:49:28 jokey Exp $

EAPI="2"

inherit eutils versionator flag-o-matic

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit."
HOMEPAGE="http://wxwidgets.org/"

BASE_PV="$(get_version_component_range 1-3)"
BASE_P="${PN}-${BASE_PV}"

# we use the wxPython tarballs because they include the full wxGTK sources and
# docs, and are released more frequently than wxGTK.
SRC_URI="mirror://sourceforge/wxpython/wxPython-src-${PV}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X doc debug gnome gstreamer odbc opengl pch sdl"

RDEPEND="
	dev-libs/expat
	odbc?   ( dev-db/unixODBC )
	sdl?    ( media-libs/libsdl )
	X?  (
		>=x11-libs/gtk+-2.4
		>=dev-libs/glib-2.4
		media-libs/jpeg
		media-libs/tiff
		x11-libs/libSM
		x11-libs/libXinerama
		x11-libs/libXxf86vm
		gnome?  ( gnome-base/libgnomeprintui )
		gstreamer? (
			>=gnome-base/gconf-2.0
			>=media-libs/gstreamer-0.10 )
		opengl? ( virtual/opengl )
		)"

DEPEND="${RDEPEND}
		dev-util/pkgconfig
		X?  (
			x11-proto/xproto
			x11-proto/xineramaproto
			x11-proto/xf86vidmodeproto
			)"

PDEPEND=">=app-admin/eselect-wxwidgets-0.7"

SLOT="2.8"
LICENSE="wxWinLL-3
		GPL-2
		odbc?	( LGPL-2 )
		doc?	( wxWinFDL-3 )"

S="${WORKDIR}/wxPython-src-${PV}"

src_prepare() {
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.6.3-unicode-odbc.patch
	epatch "${FILESDIR}"/${PN}-2.8.10-collision.patch
	epatch "${FILESDIR}"/${PN}-2.8.7-mmedia.patch              # Bug #174874
	epatch "${FILESDIR}"/${PN}-2.8.10.1-slot-bake-b0rkage.patch # hidden renames in src_install, wtf
	# this version only:
	epatch "${FILESDIR}"/${P}-CVE-2009-2369.patch              # Bug #277722
	epatch "${FILESDIR}"/${P}-confilct-with-glib21.patch       # Bug #10883
}

src_configure() {
	local myconf

	append-flags -fno-strict-aliasing

	# X independent options
	myconf="--enable-compat26
			--enable-shared
			--enable-unicode
			--with-regex=builtin
			--with-zlib=sys
			--with-expat=sys
			$(use_enable debug)
			$(use_enable pch precomp-headers)
			$(use_with sdl)"

	use odbc \
		&& myconf="${myconf} --with-odbc=sys" \
		|| myconf="${myconf} $(use_with odbc)"

	# wxGTK options
	#   --enable-graphics_ctx - needed for webkit, editra
	#   --without-gnomevfs - bug #203389

	use X && \
		myconf="${myconf}
			--enable-graphics_ctx
			--enable-gui
			--with-libpng=sys
			--with-libxpm=sys
			--with-libjpeg=sys
			--with-libtiff=sys
			$(use_enable gstreamer mediactrl)
			$(use_enable opengl)
			$(use_with opengl)
			$(use_with gnome gnomeprint)
			--without-gnomevfs"

	# wxBase options
	use X || \
		myconf="${myconf}
			--disable-gui"

	mkdir "${S}"/wxgtk_build
	cd "${S}"/wxgtk_build

	ECONF_SOURCE="${S}" econf ${myconf} || die "configure failed."
}

src_compile() {
	cd "${S}"/wxgtk_build

	emake || die "make failed."

	if [[ -d contrib/src ]]; then
		cd contrib/src
		emake || die "make contrib failed."
	fi
}

src_install() {
	cd "${S}"/wxgtk_build

	emake DESTDIR="${D}" install || die "install failed."

	if [[ -d contrib/src ]]; then
		cd contrib/src
		emake DESTDIR="${D}" install || die "install contrib failed."
	fi

	cd "${S}"/docs
	dodoc changes.txt readme.txt todo30.txt
	newdoc base/readme.txt base_readme.txt
	newdoc gtk/readme.txt gtk_readme.txt

	if use doc; then
		dohtml -r "${S}"/docs/html/*
	fi

	# We don't want this
	rm "${D}"usr/share/locale/it/LC_MESSAGES/wxmsw.mo
}

pkg_postinst() {
	has_version app-admin/eselect-wxwidgets \
		&& eselect wxwidgets update
}

pkg_postrm() {
	has_version app-admin/eselect-wxwidgets \
		&& eselect wxwidgets update
}
