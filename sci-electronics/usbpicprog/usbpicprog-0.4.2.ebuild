# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A wxWidgets based (cross platform) application to communicate with the usbpicprog hardware / firmware."
HOMEPAGE="http://usbpicprog.org"
SRC_URI="mirror://sourceforge/usbpicprog/usbpicprog-software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="x11-libs/wxGTK
         dev-libs/libusb"
DEPEND="${RDEPEND}"

src_compile() {
    econf 
    emake || die
}

src_install() {
    emake DESTDIR="${D}" install || die
}

