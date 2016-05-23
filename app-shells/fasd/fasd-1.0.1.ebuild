# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Offers quick command-line access to files and directories, inspired by autojump, z and v"
HOMEPAGE="https://github.com/clvv/fasd"
SRC_URI="https://github.com/clvv/fasd/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
