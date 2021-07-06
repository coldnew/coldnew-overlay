# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Turns any device with a web browser into a secondary screen for your compute"
HOMEPAGE="https://github.com/pavlobu/deskreen"
SRC_URI="https://github.com/pavlobu/deskreen/releases/download/v${PV}/Deskreen-${PV}.AppImage"

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="binchecks strip"

S="${WORKDIR}"

src_install() {
	cp ${DISTDIR}/Deskreen-${PV}.AppImage deskreen
	dobin deskreen
}
