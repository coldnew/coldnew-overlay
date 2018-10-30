# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
EGIT_REPO_URI="https://github.com/tio/tio.git"
EGIT_COMMIT="v${PV}"
DESCRIPTION="tio - A simple TTY terminal I/O application"
HOMEPAGE="https://github.com/tio/tio"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
DEPEND=""

inherit eutils git-r3 bash-completion-r1

S=${WORKDIR}/${PN}-${PV}

src_configure() {
    ./autogen.sh || die
    econf || die 'failed on econf'
}

src_install() {
    emake install DESTDIR="${D}"
    newbashcomp ${S}/src/bash-completion/tio ${PN}
}