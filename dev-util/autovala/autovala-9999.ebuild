# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2 cmake-utils

DESCRIPTION="A program that automatically generates CMake configuration files for your Vala project"
HOMEPAGE="https://github.com/rastersoft/autovala/wiki"
EGIT_REPO_URI="https://github.com/rastersoft/autovala.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"
IUSE=""

RDEPEND="dev-util/cmake"

DEPEND="${RDEPEND}
        >=dev-lang/vala-0.18.1"
