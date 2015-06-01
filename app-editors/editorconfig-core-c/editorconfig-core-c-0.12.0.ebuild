# Copyright 2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# project is hosted on github.com, so git-2 is needed (git is deprecated)
inherit eutils git-2 cmake-utils

DESCRIPTION="EditorConfig core library written in C (for use by plugins supporting EditorConfig parsing)"
HOMEPAGE="https://github.com/editorconfig/editorconfig-core-c"

EGIT_REPO_URI="https://github.com/editorconfig/editorconfig-core-c.git"

EGIT_COMMIT="v0.12.0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-libs/libpcre:3"
RDEPEND="${DEPEND}"

IUSE=""
