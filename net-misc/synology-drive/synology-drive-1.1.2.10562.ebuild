# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib unpacker eutils versionator

DESCRIPTION="Synology Drive is the syncservice for Synology NAS."
HOMEPAGE="https://www.synology.com/de-de/dsm/cloud_services"

# version: 1.1.2.10562
# MY_PV: 1.1.2
MY_PV="$(get_version_component_range 1-3)"
# MY_REV: 10562
MY_REV="$(get_version_component_range 4-6)"

SRC_URI_BASE="https://global.download.synology.com/download/Tools/SynologyDriveClient/${MY_PV}-${MY_REV}/Ubuntu/Installer"
SRC_URI="x86? ( ${SRC_URI_BASE}/i686/synology-drive-${MY_REV}.i686.deb -> synology-drive-${PV}.i686.deb )
	 amd64? ( ${SRC_URI_BASE}/x86_64/synology-drive-${MY_REV}.x86_64.deb -> synology-drive-${PV}.x86_64.deb )"

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

	fperms 755 /opt/Synology/SynologyDrive/bin/launcher
	fperms 755 /usr/bin/synology-drive
}
