# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="the hardware-based performance monitoring interface for Linux"
HOMEPAGE="http://perfmon2.sourceforge.net/"
SRC_URI="mirror://sourceforge/perfmon2/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~dev-libs/libpfm-${PV}"
RDEPEND="${DEPEND}"

src_compile() {
	emake install_prefix=/usr CC="$(tc-getCC)" OPTIM="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install_prefix="${D}"/usr install || die "emake install failed"
}
