# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit unpacker eutils

DESCRIPTION="Synology Drive is the syncservice for Synology NAS."
HOMEPAGE="https://www.synology.com/de-de/dsm/cloud_services"

# version: 2.0.0.11050
# MY_PV: 2.0.0
MY_PV="$(ver_cut 1-3)"
# MY_REV: 11050
MY_REV="$(ver_cut 4-6)"

SRC_URI_BASE="https://global.synologydownload.com/download/Utility/SynologyDriveClient/${MY_PV}-${MY_REV}/Ubuntu/Installer"
SRC_URI="amd64? ( ${SRC_URI_BASE}/x86_64/synology-drive-client-${MY_REV}.x86_64.deb -> synology-drive-${PV}.x86_64.deb )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/icu"
RDEPEND="${DEPEND}"

QA_PREBUILT="*"
RESTRICT="strip"

S="${WORKDIR}"

src_install() {
	cp -a opt usr "${D}" || die
	rm -rf ${D}/_gpgbuilder
	rm -rf ${D}/usr/share/doc/synology-drive
}
