# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils multilib

DESCRIPTION="Parrot is a virtual machine designed to efficiently compile and execute bytecode for dynamic languages"
HOMEPAGE="http://www.parrot.org/"
SRC_URI="ftp://ftp.parrot.org/pub/parrot/releases/stable/${PV}/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE="opengl nls doc examples gdbm gmp ssl unicode pcre"

RDEPEND="opengl? ( virtual/glut )
		 nls? ( sys-devel/gettext )
		 unicode? ( >=dev-libs/icu-2.6 )
		 gdbm? ( >=sys-libs/gdbm-1.8.3-r1 )
		 gmp? ( >=dev-libs/gmp-4.1.4 )
		 ssl? ( dev-libs/openssl )
		 pcre? ( dev-libs/libpcre )"

DEPEND="dev-lang/perl[doc?]
		${RDEPEND}"

src_prepare() {
	sed -e "s:/lib/:/$(get_libdir)/:" -i "${S}/tools/dev/install_files.pl"
}

src_configure() {
	myconf=""
	use unicode || myconf="$myconf --without-icu"
	use ssl || myconf="$myconf --without-crypto"
	use gdbm || myconf="$myconf --without-gdbm"
	use nls || myconf="$myconf --without-gettext"
	use gmp || myconf="$myconf --without-gmp"
	use opengl || myconf="$myconf --without-opengl"
	use pcre || myconf="$myconf --without-pcre"

	perl Configure.pl --prefix=/usr \
					  --libdir=/usr/$(get_libdir) \
					  --sysconfdir=/etc \
					  --sharedstatedir=/var/lib/parrot \
					  $myconf
}

src_compile() {
	emake || die
	use doc && make html
}

src_install() {
	emake -j1 install DESTDIR="${D}" DOC_DIR="/usr/share/doc/${P}" || die
}
