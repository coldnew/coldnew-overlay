# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib unpacker eutils

DESCRIPTION="Synology Cloudstation is the syncservice for Synology NAS."
HOMEPAGE="https://www.synology.com/de-de/dsm/cloud_services"
SRC_URI_BASE="http://global.download.synology.com/download/Tools/CloudStationDrive/4.2.6-${PV}/Ubuntu/Installer"
SRC_URI="x86? ( ${SRC_URI_BASE}/i686/synology-cloud-station-drive-${PV}.i686.deb -> synology-cloud-station-drive-${PV}.i686.deb )
		amd64? ( ${SRC_URI_BASE}/x86_64/synology-cloud-station-drive-${PV}.x86_64.deb -> synology-cloud-station-drive-${PV}.x86_64.deb )"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/icu"
RDEPEND="${DEPEND}"

QA_PREBUILT="*"
RESTRICT="strip"

S="${WORKDIR}"

src_install() {
	insinto "/"
	doins -r *

	fperms 755 /opt/Synology/CloudStation/bin/launcher
	fperms 755 /usr/bin/synology-cloud-station-drive
}
