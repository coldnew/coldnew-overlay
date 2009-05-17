# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Sieve Command Line Interface"
HOMEPAGE="http://people.spodhuis.org/phil.pennock/software/"
SRC_URI="http://people.spodhuis.org/phil.pennock/software/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5
	dev-perl/Authen-SASL
	dev-perl/IO-Socket-INET6
	>=dev-perl/IO-Socket-SSL-0.97
	dev-perl/TermReadKey
	dev-perl/Term-ReadLine-Gnu"

src_compile() {
	true
}

src_install() {
	newbin ${PN}.pl ${PN} || die "newbin failed"
	doman ${PN}.1
	dodoc ChangeLog
}
