# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2 cmake-utils

DESCRIPTION="A program that automatically generates CMake configuration files for your Vala project"
HOMEPAGE="https://gitlab.com/rastersoft/autovala"
EGIT_REPO_URI="https://gitlab.com/rastersoft/autovala.git"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"
IUSE=""

RDEPEND="dev-util/cmake
        app-text/pandoc"

DEPEND="${RDEPEND}
        >=dev-lang/vala-0.18.1
	>=dev-libs/libgee-0.8
"

# FIXME: I can't get it why cmake-utils_src_make will failed here.
src_compile() {
    cd ${S}_build
    make
}
