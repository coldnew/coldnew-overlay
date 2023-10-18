# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1

DESCRIPTION="An easy way to virtualize the running system "
HOMEPAGE="https://github.com/arighi/virtme-ng"
SRC_URI="https://github.com/arighi/virtme-ng/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

RDEPEND="app-emulation/qemu"
DEPEND="${PYTHON_DEPS}"

