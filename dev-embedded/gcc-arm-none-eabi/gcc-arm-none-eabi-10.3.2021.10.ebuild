# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# http://distortos.org/documentation/building-kconfig-frontends-linux/
EAPI=6

SRC_URI="https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/${PN}-9-2020-q2-update-x86_64-linux.tar.bz2"
KEYWORDS="~amd64"

DESCRIPTION="GNU Arm Embedded Toolchain Version 9-2020-q2-update"
HOMEPAGE="https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
DEPEND=""

inherit eutils

S=${WORKDIR}/${PN}-9-2020-q2-update

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
