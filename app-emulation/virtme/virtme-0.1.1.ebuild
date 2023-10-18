# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1

DESCRIPTION="An easy way to virtualize the running system "
HOMEPAGE="https://github.com/amluto/virtme"
SRC_URI="https://mirrors.edge.kernel.org/pub/linux/utils/kernel/virtme/releases/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

RDEPEND="app-emulation/qemu"
DEPEND="${PYTHON_DEPS}"

