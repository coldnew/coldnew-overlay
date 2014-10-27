# Copyright 2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# project is hosted on github.com, so git-2 is needed (git is deprecated)
inherit eutils git-2 systemd

DESCRIPTION="My Macbook Air 2013 configs for Gentoo Linux."
HOMEPAGE="http://github.com/coldnew/macbookair-2013-config"

EGIT_REPO_URI="git://github.com/coldnew/macbookair-2013-config.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	net-wireless/broadcom-sta
"
RDEPEND="${DEPEND}"

IUSE="systemd"


TARGET_DIR_NAME="/usr/share/macbookair-2013"

src_install() {

    # Install xofg configs
    dodir /etc/X11/xorg.conf.d
    insinto /etc/X11/xorg.conf.d
    doins etc/X11/xorg.conf.d/50-synaptics.conf

    # Install sbin command
    dosbin boot-update

    # Install files to /usr/share/macbookair-2013/
    dodir $TARGET_DIR_NAME

    insinto $TARGET_DIR_NAME
    doins kernel-config.example
    doins fstab.example
    doins grub.example

    exeinto $TARGET_DIR_NAME
    doexe local-service

    # Install systemd stuff
    systemd_dounit etc/systemd/system/my-stuff.service

    # start systemd
    systemd_enable_service multiuser.target my-stuff.service
}

pkf_postinst() {
    elog "Install my Macbookair 2013 configs finish."
}
