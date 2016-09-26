# Copyright 2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# project is hosted on github.com, so git-2 is needed (git is deprecated)
inherit eutils git-2 cmake-utils

DESCRIPTION=" Share your terminal over the web "
HOMEPAGE="https://github.com/tsl0922/ttyd"

EGIT_REPO_URI="https://github.com/tsl0922/ttyd.git"

EGIT_COMMIT="1.0.0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="net-libs/libwebsockets
        dev-libs/json-c
        dev-libs/openssl"
RDEPEND="${DEPEND}"

IUSE=""
