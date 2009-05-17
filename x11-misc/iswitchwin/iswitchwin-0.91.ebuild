# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="iswitchwin lets you easily switch between windows on your workspaces"
HOMEPAGE="http://martinman.net/software/iswitchwin"
SRC_URI="http://martinman.net/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/glib
	dev-libs/dbus-glib
	gnome-base/libglade
	x11-libs/libwnck"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
}
