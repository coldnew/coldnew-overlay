# Copyright 2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# project is hosted on github.com, so git-2 is needed (git is deprecated)
inherit eutils git-2 cmake-utils

DESCRIPTION="coldnew's MacbookPro Retina Early 2015 configs for Gentoo Linux."
HOMEPAGE="https://github.com/editorconfig/editorconfig-core-c"

EGIT_REPO_URI="https://github.com/editorconfig/editorconfig-core-c.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libpcre"
RDEPEND="${DEPEND}"

IUSE=""
