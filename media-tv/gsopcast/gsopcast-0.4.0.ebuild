# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils autotools 

#ESVN_REPO_URI="http://gsopcast.googlecode.com/svn/trunk"
#ESVN_PROJECT="gsopcast"

MY_P="${P/m/M}"
DESCRIPTION="a gtk front-end of p2p TV sopcast" 
SRC_URI="http://gsopcast.googlecode.com/files/${MY_P}.tar.bz2"
HOMEPAGE="http://lianwei3.googlepages.com/home2"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=media-tv/sopcast-1.1.1
    net-misc/curl
    media-libs/alsa-lib
    >=x11-libs/gtk+-2"
RDEPEND="${DEPEND}" 

#pkg_setup() {
#   ewarn "This is a LIVE SVN ebuild."
#   ewarn "That means there are NO promises it will work."
#}

src_compile() {
        ./autogen.sh
        econf || die "configure failed"
        emake || die "make failed"
}


src_install() {
        einstall || die
}


src_unpack() {
	unpack ${P}.tar.bz2
        cd "${S}"
	epatch "${FILESDIR}"/${PN}-gcc4.3.patch
}
