# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

inherit eutils cmake-utils git

DESCRIPTION=""
HOMEPAGE=""
#SRC_URI="git://github.com/coldnew/celib.git"
EGIT_REPO_URI="git://github.com/coldnew/celib.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}
         dev-util/cmake
		" 

MAKEOPTS="-j1"


src_unpack() {
git_src_unpack
	cd "${S}"


}

src_compile() {
	mycmakeargs="${mycmakeargs}"

	cmake-utils_src_compile

#econf || die "configure failed"
#	emake || die
}

src_install() {
	cmake-utils_src_install

	#cd "${S}"
	#make DESTDIR="${D}" install || die

	dodoc README
}

