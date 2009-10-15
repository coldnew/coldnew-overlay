# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit mono autotools

DESCRIPTION="An instant messenger application designed for the GNOME desktop"
HOMEPAGE="http://code.google.com/p/galaxium/"
SRC_URI="http://galaxium.googlecode.com/files/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="webkit"

DEPEND=">=dev-dotnet/mono-addins-0.3
	>=dev-lang/mono-1.2.4
	>=dev-dotnet/gtk-sharp-2.10.2
	>=dev-dotnet/glade-sharp-2.10.0
	>=dev-dotnet/gecko-sharp-0.10
	>=dev-dotnet/dbus-sharp-0.4.2
	>=dev-dotnet/dbus-glib-sharp-0.3
	>=media-libs/gstreamer-0.10
	>=dev-dotnet/libanculus-sharp-0.3
	webkit? ( >=dev-dotnet/webkit-sharp-0.2 )"
RDEPEND="${DEPEND}
	media-libs/swfdec"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf \
		--enable-gecko \
		$(use_enable webkit) \
			|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}

