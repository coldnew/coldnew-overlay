# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils udev user git-2

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
EGIT_REPO_URI="https://github.com/libimobiledevice/usbmuxd.git"

# src/utils.h is LGPL-2.1+, rest is found in COPYING*
LICENSE="GPL-2 GPL-3 LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.1.6
	>=app-pda/libplist-1.11
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

S=${WORKDIR}

src_configure() {
	local PREFIX="${EPREFIX}"/usr LIBDIR='$(PREFIX)'/$(get_libdir)
	./autogen.sh --prefix="${PREFIX}" --libdir="${LIBDIR}" --with-systemd
}

pkg_setup() {
	enewgroup plugdev
	enewuser usbmux -1 -1 -1 "usb,plugdev"
}

src_install() {
	emake -j1 DESTDIR="${D}" install
}
