# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5


inherit systemd git-2

DESCRIPTION="Creates virtual Ethernet networks of almost unlimited size."
HOMEPAGE="https://www.zerotier.com/index.html"
LICENSE="GPL-3"

EGIT_REPO_URI="https://github.com/zerotier/ZeroTierOne.git"
EGIT_BRANCH="master"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""
DEPEND=""
RDEPEND=""

src_compile() {
    emake || die
}

src_test() {
    emake selftest || die
    ./zerotier-selftest || die
}

src_install() {
    # Install to /var/lib/zerotier-one
    exeinto /var/lib/zerotier-one
    doexe zerotier-one

    dobin zerotier-cli
    dobin zerotier-idtool

    # Install systemd stuff
    systemd_dounit ext/installfiles/linux/systemd/zerotier-one.service

    # start systemd unit
    systemd_enable_service multiuser.target zerotier-one.service
}