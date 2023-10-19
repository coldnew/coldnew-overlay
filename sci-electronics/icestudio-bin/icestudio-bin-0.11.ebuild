# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

case ${ARCH} in
    x86)   MY_ARCH="linux32" ;;
    amd64) MY_ARCH="linux64" ;;
esac

# when this pkg not official release, toggle this flag
IS_DEV=0

if [ ${IS_DEV} -eq 1 ]; then
   MY_ARCH="dev-${MY_ARCH}"
fi

DESCRIPTION="Visual editor for open FPGA boards"
HOMEPAGE="https://github.com/FPGAwars/icestudio"
SRC_URI="https://github.com/FPGAwars/icestudio/releases/download/v${PV}/icestudio-${PV}-${MY_ARCH}.zip -> ${P}-${MY_ARCH}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPENDS="x11-misc/xclip dev-lang/python"
RDEPEND=""

S="${WORKDIR}/icestudio-${PV}-${MY_ARCH}"
QA_PREBUILT="opt/icestudio/icestudio"

src_install()
{
    insinto /opt/icestudio
    insopts -m 0755
    doins -r ${S}/* || die "doins /opt failed"

    dodir /opt/bin
    dosym ../icestudio/icestudio /opt/bin/icestudio || die "dosym /opt/bin/icestudio"
}
