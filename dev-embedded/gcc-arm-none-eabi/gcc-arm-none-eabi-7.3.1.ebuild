# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# http://distortos.org/documentation/building-kconfig-frontends-linux/
EAPI=6

SRC_URI="https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/7-2018q2/${PN}-7-2018-q2-update-linux.tar.bz2"
KEYWORDS="~amd64"

DESCRIPTION="GNU Arm Embedded Toolchain Version 7-2018-q2-update"
HOMEPAGE="https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
DEPEND=""

inherit eutils

S=${WORKDIR}/${PN}-7-2018-q2-update

src_install() {
    local dir="/opt/${PN}-${PV}"

    insinto "${dir}"
    insopts -m 0755
    doins -r ${S}/* || die "doins /opt failed"

    cd "${S}/bin"
    for i in *; do
	dosym "${dir}/bin/${i}" "/usr/bin/${i}"
    done
}
