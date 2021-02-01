# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

if [[ ${PV} == 9999* ]]; then
   EGIT_REPO_URI="https://github.com/tio/tio.git"
   inherit git-r3
else
    SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.xz -> ${P}.tar.xz"
    KEYWORDS="~x86 ~amd64"
fi

DESCRIPTION="tio - A simple TTY terminal I/O application"
HOMEPAGE="https://github.com/tio/tio"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
DEPEND=""

inherit eutils bash-completion-r1

S=${WORKDIR}/${PN}-${PV}

src_configure() {
    if [[ ${PV} == 9999* ]]; then
	./autogen.sh || die
    fi
    econf || die 'failed on econf'
}

src_install() {
    emake install DESTDIR="${D}"
    newbashcomp ${S}/src/bash-completion/tio ${PN}
}