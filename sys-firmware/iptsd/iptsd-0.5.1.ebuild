# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson
inherit eutils
inherit ninja-utils

DESCRIPTION="Userspace daemon for Intel Precise Touch & Stylus"
HOMEPAGE="https://github.com/linux-surface/iptsd"
SRC_URI="https://github.com/linux-surface/iptsd/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND="dev-libs/inih"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/ninja sys-devel/gcc dev-util/meson"

PATCHES=(
	"${FILESDIR}/0001-meson-with-systemd-option.0.5.1.patch"
)

src_configure() {
	local emesonargs=(
		$(meson_use systemd)
	)
	meson_src_configure
}


