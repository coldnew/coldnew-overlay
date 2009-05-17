# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator toolchain-funcs multilib linux-info

DESCRIPTION="Linux Performance Counters"
HOMEPAGE="http://user.it.uu.se/~mikpe/linux/perfctr/"
SRC_URI="http://user.it.uu.se/~mikpe/linux/perfctr/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

CONFIG_CHECK="~PERFCTR"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake \
		PREFIX="${D}/usr" \
		BINDIR="${D}/usr/bin" \
		LIBDIR="${D}/usr/$(get_libdir)" \
		INCLDIR="${D}/usr/include" \
		ETCDIR="${D}/etc" \
		install \
		|| die "emake install failed"

	# Cleanup
	rm -rf "${D}"/etc/rc.d
	mv "${D}"/etc/udev.d "${D}"/etc/udev
}
