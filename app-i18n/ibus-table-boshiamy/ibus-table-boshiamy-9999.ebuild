# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit eutils git-2

DESCRIPTION="Boshiamy input tables for ibus-table"
HOMEPAGE="https://github.com/coldnew/ibus-table-boshiamy"

EGIT_REPO_URI="https://github.com/coldnew/ibus-table-boshiamy.git"
#EGIT_COMMIT=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/ibus-table-1.2.0"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
