# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit flag-o-matic eutils multilib autotools git-2 autotools

DESCRIPTION="PCMan is an easy-to-use telnet client mainly targets BBS users formerly writen by gtk2"
HOMEPAGE="https://github.com/pcman-bbs/pcmanx"
EGIT_REPO_URI="https://github.com/pcman-bbs/pcmanx.git"

EGIT_COMMIT="40db5a8e615f9596dcb98fb62cc88215780615e1"

KEYWORDS="amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="+libnotify +proxy iplookup +wget"

# FIXME:
# pcmanx-gtk2 needs xulrunner
COMMON_DEPEND="
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXft
	>=x11-libs/gtk+-2.4
"

RDEPEND="
${COMMON_DEPEND}
	wget? ( net-misc/wget )
"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
"

RESTRICT="mirror"

src_prepare() {
	sh autogen.sh || die "autogen"	
}

src_configure() {
	# better move this to pkg_setup phase?
	# this flag crashes CTermData::memset16()
	filter-flags -ftree-vectorize

	econf $(use_enable proxy) \
		$(use_enable libnotify) \
		$(use_enable wget)\
		$(use_enable iplookup)
}

