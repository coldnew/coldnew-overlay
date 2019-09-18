# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# http://distortos.org/documentation/building-kconfig-frontends-linux/
EAPI=6

SRC_URI="https://github.com/gnu-mcu-eclipse/riscv-none-gcc/releases/download/v8.2.0-2.2-20190521/gnu-mcu-eclipse-riscv-none-gcc-8.2.0-2.2-20190521-0004-centos64.tgz"
KEYWORDS="~amd64"

DESCRIPTION="GNU Arm Embedded Toolchain Version 7-2018-q2-update"
HOMEPAGE="https://github.com/gnu-mcu-eclipse/riscv-none-gcc/"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
DEPEND=""

inherit eutils

S="${WORKDIR}/gnu-mcu-eclipse/${PN}/8.2.0-2.2-20190521-0004"

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
