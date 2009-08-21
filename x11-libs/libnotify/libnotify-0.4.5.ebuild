# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libnotify/libnotify-0.4.5.ebuild,v 1.12 2009/08/08 16:36:54 ssuominen Exp $

EAPI=2

DESCRIPTION="Notifications library"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=dev-libs/glib-2.6:2
	>=dev-libs/dbus-glib-0.76"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
PDEPEND="|| ( x11-misc/notification-daemon
	x11-misc/xfce4-notifyd 
	x11-misc/notify-osd )"

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS
}
