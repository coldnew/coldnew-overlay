# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="Performance Application Programming Interface"
HOMEPAGE="http://icl.cs.utk.edu/papi/"
SRC_URI="http://icl.cs.utk.edu/projects/papi/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-util/perfctr-2.6.27"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${P}/src

src_compile() {
	econf \
		--with-perfctr-incdir=/usr/include \
		--with-perfctr-libdir=/usr/$(get_libdir) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/$(get_libdir)
	einstall \
		LIBDIR="${D}/usr/$(get_libdir)" \
		MANDIR="${D}/usr/share/man" \
		|| die "einstall failed"
}
