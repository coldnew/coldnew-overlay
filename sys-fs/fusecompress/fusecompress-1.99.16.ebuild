# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="FuseCompress - compresses filesystem"
HOMEPAGE="http://www.miio.net/fusecompress/"
SRC_URI="http://miio.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-fs/fuse-2.4.1-r1
	>=app-arch/bzip2-1.0.3-r5
	>=sys-libs/zlib-1.2.3
	>=dev-libs/rlog-1.3.7"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	
	epatch "${FILESDIR}"/fusecompress-1.99.16-gcc-4.3.patch
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc ChangeLog README
}
