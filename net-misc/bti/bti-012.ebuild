# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="bti - bash twitter idiocy"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/gregkh/bti/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/gregkh/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 sparc"
IUSE="doc"

DEPEND=""
RDEPEND=""

src_install() {
	dobin bti
	doman bti.1
	dodoc ChangeLog README RELEASE-NOTES bti.example
	if use doc; then
		dodoc bti.xml
	fi
}
