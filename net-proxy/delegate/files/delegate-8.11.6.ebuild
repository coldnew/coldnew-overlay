# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

MY_P="${PN}${PV}"

DESCRIPTION="DeleGate is a multi-purpose application level gateway."
HOMEPAGE="http://www.delegate.org/delegate/"
SRC_URI="
ftp://ftp:unknown%40unknown%2Enet@ftp.delegate.org/pub/DeleGate/old/${MY_P}.tar.gz
"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~mips ~arm ~hppa"
IUSE="doc"

S="${WORKDIR}/${MY_P}/"

src_compile(){
	if [ ! -e ./src/Makefile.oRiG ]; then
		cp ./src/Makefile ./src/Makefile.oRiG || die
		cat ./src/Makefile.oRiG | \
		sed -e "s/^\(ADMIN\) = undef$/\1 = unknown\@${HOSTNAME}.unknown.org/" \
		> ./src/Makefile || die
	fi
	emake || die
}

src_install(){
	dosbin ./src/delegated &&
	newconfd ${FILESDIR}/delegated.confd delegated &&
	newinitd ${FILESDIR}/delegated.initd delegated \
	|| die

	if use doc ; then
		dodoc CHANGES COPYRIGHT CREDITS INSTALL README* &&
		dohtml ./doc/*htm || die
	fi
}
