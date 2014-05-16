# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils git-2

DESCRIPTION="Tools for working with the opkg binary package format"
HOMEPAGE="http://code.google.com/p/opkg/"
EGIT_REPO_URI="git://git.yoctoproject.org/opkg-utils"
#EGIT_COMMIT=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="opkg.py"

src_prepare() {
	PREFIX="PREFIX=/usr"
        sed "/PREFIX=/c\ $PREFIX" -i Makefile
}

src_compile() {
        emake CC="$(tc-getCC)" || die "emake failed"
}

pkg_postinst() {
	elog "Consider installing sys-apps/fakeroot for use with the opkg-build command,"
	elog "that makes it possible to build packages as a normal user."
}
