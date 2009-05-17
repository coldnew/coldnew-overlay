# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit pam eutils

DESCRIPTION="execute scripts during authorization, password changes and sessions"
HOMEPAGE="https://sourceforge.net/projects/pam-script/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-include-order.patch
}

src_install() {
	dopammod .libs/pam_script.so
	dodoc AUTHORS ChangeLog NEWS README
}
