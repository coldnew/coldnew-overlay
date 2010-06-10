# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/alliance/alliance-5.0.20070718.ebuild,v 1.3 2008/11/26 21:59:11 halcy0n Exp $

inherit versionator flag-o-matic rpm eutils

MY_PV=$(replace_version_separator 2 '-' )
UPSTREAM_VERSION=$(get_version_component_range 1-2)
URL_AND_NAME="http://www-asim.lip6.fr/pub/alliance/distribution/${UPSTREAM_VERSION}/${PN}"
DESCRIPTION="Digital IC design tools (simulation, synthesis, place/route, etc...)."
HOMEPAGE="http://www-asim.lip6.fr/recherche/alliance/"
SRC_URI="${URL_AND_NAME}-${MY_PV}.tar.gz"
	#doc? ( ${URL_AND_NAME}-tutorials-${MY_PV}.i386.rpm )"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
DEPEND="x11-libs/openmotif"
S="${WORKDIR}/${PN}-${UPSTREAM_VERSION}"

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/alliance-5.0-gcc43.patch

	# Fix compilation issue
	sed -i -e "s/private: static void  operator delete/public: static void  operator delete/" nero/src/ADefs.h || die "sed failed"
}

src_compile() {
	# Fix bug #134285
	replace-flags -O3 -O2

	# Alliance requires everything to be in the same directory
	econf \
		--prefix=/usr/lib/${PN} \
		--mandir=/usr/lib/${PN}/man \
		--with-x \
		--with-motif \
		--with-xpm \
		|| die "./configure failed"

	# See bug #134145
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}"
	insinto /etc
	newins distrib/etc/alc_env.sh alliance.env
	if use doc
	then
		insinto /usr/share/doc/${PF}
		doins -r "${WORKDIR}"/opt/${PN}-${UPSTREAM_VERSION}/*
	fi
}

pkg_postinst() {
	elog "Users should source /etc/alliance.env before working with Alliance tools."
}
