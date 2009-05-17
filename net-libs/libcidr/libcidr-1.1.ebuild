# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="IP CIDR address manipulation"
HOMEPAGE="http://www.over-yonder.net/~fullermd/projects/libcidr/"
SRC_URI="http://www.over-yonder.net/~fullermd/projects/libcidr/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -I${S}/include -I${S}/src/include" \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}/usr" \
		MANDIR="\$(DESTDIR)/share/man" \
		DOCDIR="${T}" \
		EXDIR="${T}" \
		install \
		|| die "emake install failed"

	doman docs/libcidr.3
	dodoc README docs/reference/libcidr.txt
	dohtml docs/reference/{libcidr-big.html,codelibrary-html.css}
}
