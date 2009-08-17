# ==========================================================================
# This ebuild come from voyageur repository. Zugaina.org only host a copy.
# For more info go to http://gentoo.zugaina.org/
# ************************ General Portage Overlay  ************************
# ==========================================================================
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Canonical's on-screen-display notification agent"
HOMEPAGE="https://launchpad.net/notify-osd"

SRC_URI="http://launchpad.net/notify-osd/0.9/${P}/+download/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"
RDEPEND="!x11-misc/notification-daemon
	sys-apps/dbus
	>=x11-libs/gtk+-2.14
	x11-libs/libnotify
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/intltool"

#src_unpack() {
#	    unpack ${A}
#		cd "${S}"
#		epatch "${FILESDIR}"/fix_makefile.patch
#}
src_configure() {
#	append-flags -fno-strict-aliasing # -Werror causes build to fail
	filter-flags -Werror
#	default
} 

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
}
