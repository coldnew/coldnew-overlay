# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# http://distortos.org/documentation/building-kconfig-frontends-linux/
EAPI=6

SRC_URI="http://ymorin.is-a-geek.org/download/kconfig-frontends/${P}.tar.xz"
KEYWORDS="~x86 ~amd64"

DESCRIPTION="Out of the Linux source tree, packaging of the kconfig infrastructure, ready for use by third party projects"
HOMEPAGE="http://ymorin.is-a-geek.org/projects/kconfig-frontends"
SLOT="0"
LICENSE="GPL-2"
IUSE="gtk qt5"
DEPEND="
    sys-libs/ncurses:0[tinfo]
    qt5? (
       dev-qt/qtcore:5
       dev-qt/qtgui:5
       dev-qt/qtwidgets:5
    )
    gtk? (
       x11-libs/gtk+:3
    )
"

inherit eutils

S=${WORKDIR}/${PN}-${PV}

src_prepare() {
    epatch "${FILESDIR}"/0001-fix-build-error.patch
    # https://bugs.gentoo.org/651914
    epatch "${FILESDIR}"/0002-fix-gentoo-ncurses-bug.patch

    eapply_user
}

src_configure() {
    local myconf

    if use gtk; then
	myconf+=" --enable-gconf "
    else
	myconf+=" --disable-gconf "
    fi
    if use qt5; then
	myconf+=" --enable-qconf "
    else
	myconf+=" --disable-qconf "
    fi

    econf \
	--enable-mconf \
	${myconf}
}

src_install() {
    emake install DESTDIR="${D}"
}
