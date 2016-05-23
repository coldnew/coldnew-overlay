# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-2

DESCRIPTION="Offers quick command-line access to files and directories, inspired by autojump, z and v"
EGIT_REPO_URI="git://github.com/clvv/fasd.git"
HOMEPAGE="https://github.com/clvv/fasd"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
