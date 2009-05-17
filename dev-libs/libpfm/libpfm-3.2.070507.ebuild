# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator toolchain-funcs

MY_P="${PN}-$(replace_version_separator 2 -)"

DESCRIPTION="the hardware-based performance monitoring interface for Linux"
HOMEPAGE="http://perfmon2.sourceforge.net/"
SRC_URI="mirror://sourceforge/perfmon2/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_P}

src_compile() {
	emake -j1 install_prefix=/usr CC="$(tc-getCC)" OPTIM="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake -j1 install_prefix="${D}"/usr install || die "emake install failed"
}
