# Copyright 1999-2023 Gentoo Authors

EAPI=8

# get the current value from the yosys makefile...look for ABCREV
ABC_GIT_COMMIT=896e5e7dedf9b9b1459fa019f1fa8aa8101fdf43

DESCRIPTION="framework for Verilog RTL synthesis"
HOMEPAGE="http://www.clifford.at/yosys/"
SRC_URI="
	https://github.com/YosysHQ/${PN}/archive/${P}.tar.gz
	https://github.com/YosysHQ/abc/archive/${ABC_GIT_COMMIT}.tar.gz -> abc-${ABC_GIT_COMMIT}.tar.gz
"
LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/boost
	media-gfx/xdot
	sys-devel/clang
"

DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git"

PATCHES=(
)

QA_PRESTRIPPED="
	/usr/bin/yosys-filterlib
	/usr/bin/yosys-abc
"

S="${WORKDIR}/${PN}-${PN}-${PV}"

src_prepare() {
	mv "${WORKDIR}/abc-${ABC_GIT_COMMIT}" "${S}"/abc || die
	default
}

src_install() {
	emake DESTDIR="${D}" PREFIX='/usr' install
}
