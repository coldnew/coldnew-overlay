# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

EGIT_REPO_URI="https://github.com/stanford-scs/jai.git"

DESCRIPTION="An ultra lightweight jail for AI CLIs on modern linux"
HOMEPAGE="https://jai.scs.stanford.edu/ https://github.com/stanford-scs/jai"
LICENSE="GPL-3+"

SLOT="0"
KEYWORDS=""
IUSE="bash-completion"

RDEPEND="
	sys-apps/systemd
	sys-libs/libcap
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/gperf
	sys-devel/automake
	sys-devel/autoconf
"

PATCHES=(
	"${FILESDIR}/jai-cxx23-fix.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-untrusted-user=jai \
		$(use_enable bash-completion)
}

src_install() {
	dobin jai

	fowners root:0 /usr/bin/jai
	fperms 04511 /usr/bin/jai

	insinto /usr/lib/sysusers.d
	doins jai.conf

	newenvd - 99jai <<< "j jai -1 -1 - - JAI sandbox untrusted user"

	if use bash-completion; then
		insinto /usr/share/bash-completion/completions
		doins bash-completion/jai
	fi
}

pkg_postinst() {
	einfo "To create the jai untrusted user, run:"
	einfo "  systemd-sysusers /usr/lib/sysusers.d/jai.conf"
}
