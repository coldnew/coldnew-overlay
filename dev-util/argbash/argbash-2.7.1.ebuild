# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
EGIT_REPO_URI="https://github.com/matejak/argbash.git"
EGIT_COMMIT="${PV}"
DESCRIPTION="Bash argument parsing code generator"
HOMEPAGE="https://github.com/matejak/argbash"
KEYWORDS=" x86 amd64 arm"
SLOT="0"
LICENSE="BSD-3"
IUSE=""
DEPEND="app-shells/bash"

inherit eutils git-2

src_install() {
    cd "${WORKDIR}/${PN}-${PV}/resources"
    emake install PREFIX=${D} || die 'make install failed'
}
