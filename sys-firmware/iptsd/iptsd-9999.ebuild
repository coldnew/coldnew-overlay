# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson eutils ninja-utils udev git-r3

DESCRIPTION="Userspace daemon for Intel Precise Touch & Stylus"
HOMEPAGE="https://github.com/linux-surface/iptsd"
EGIT_REPO_URI="https://github.com/linux-surface/iptsd.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND="
    dev-libs/inih
    dev-libs/hidrd
    dev-libs/libfmt
    dev-libs/spdlog
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/ninja sys-devel/gcc dev-util/meson"

PATCHES=(
	"${FILESDIR}/0001-meson-with-systemd-option.9999.patch"
)

src_configure() {
	local emesonargs=(
		$(meson_use systemd)
	)
	meson_src_configure
}


