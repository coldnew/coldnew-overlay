# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

SRC_URI="https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/${PN}-10.3-2021.10-x86_64-linux.tar.bz2"
KEYWORDS="~amd64"

DESCRIPTION="GNU Arm Embedded Toolchain Version 10.3-2021.10"
HOMEPAGE="https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
DEPEND=""

S=${WORKDIR}/${PN}-10.3-2021.10

src_install() {
    local dir="/opt/${PN}-${PV}"

    insinto "${dir}"
    insopts -m 0755
    doins -r ${S}/* || die "doins /opt failed"

    cd "${S}/bin" || die
    for i in *; do
	dosym "${dir}/bin/${i}" "/usr/bin/${i}"
    done
}
