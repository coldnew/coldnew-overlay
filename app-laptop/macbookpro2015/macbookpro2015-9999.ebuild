# Copyright 2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

# project is hosted on github.com, so git-2 is needed (git is deprecated)
inherit git-r3 systemd

DESCRIPTION="coldnew's MacbookPro Retina Early 2015 configs for Gentoo Linux."
HOMEPAGE="http://github.com/coldnew/macbookpro-2015-config"

EGIT_REPO_URI="https://github.com/coldnew/macbookpro-2015-config.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
sys-fs/diskdev_cmds
"
RDEPEND="${DEPEND}"

IUSE="systemd"

TARGET_DIR_NAME="/usr/share/macbookpro-2015"

src_install() {

    # Install xofg configs
    dodir /etc/X11/xorg.conf.d
    insinto /etc/X11/xorg.conf.d
    doins etc/X11/xorg.conf.d/50-synaptics.conf

    # Install sbin command
    dosbin boot-update

    # Install files to /usr/share/macbookair-2013/
    dodir $TARGET_DIR_NAME

#    insinto $TARGET_DIR_NAME
#    doins kernel-config.example
#    doins fstab.example
#    doins grub.example

    exeinto $TARGET_DIR_NAME
    doexe mbpr2015-service

    # Install systemd stuff
    systemd_dounit etc/systemd/system/mbpr2015-config.service

    # start systemd
    systemd_enable_service multiuser.target mbpr2015-config.service

    #
    insinto /usr/lib/sysctl.d
    doins usr/lib/sysctl.d/60-myself.conf

	insinto /etc/modprobe.d
	doins etc/modprobe.d/hid_apple.conf

	# Initial some environment variables setting	
	insinto /etc/profile.d
	doins etc/profile.d/qt-hidpi.sh

}

pkf_postinst() {
    elog "Install coldnew's MacbookPro Retina Early 2015 configs finish."
}
