# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit multilib

DESCRIPTION="Verilog compiler and simulator"
HOMEPAGE="http://www.veripool.org/wiki/verilator"
SRC_URI="https://github.com/verilator/verilator/archive/refs/tags/v${PV}.tar.gz"

LICENSE="|| ( Artistic-2 LGPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

