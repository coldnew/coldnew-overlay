# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="C library for symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
EGIT_REPO_URI="https://github.com/ianlancetaylor/libbacktrace.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake CFLAGS="-fPIC"
}
