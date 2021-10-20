EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10} )
inherit eutils python-any-r1

ABC_GIT_COMMIT="4f5f73d18b137930fb3048c0b385c82fa078db38"

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="http://www.clifford.at/icestorm/"
SRC_URI="https://github.com/YosysHQ/${PN}/archive/refs/tags/${P}.tar.gz -> ${P}.tar.gz
		https://github.com/YosysHQ/abc/archive/${ABC_GIT_COMMIT}.tar.gz -> abc-${ABC_GIT_COMMIT}.tar.gz"
KEYWORDS="~amd64"
LICENSE="ISC"
SLOT="0"
IUSE="tcl +abc plugins readline clang"

RDEPEND="
	tcl? ( dev-lang/tcl )
	plugins? ( virtual/libffi virtual/pkgconfig )
	readline? ( sys-libs/readline )
"

DEPEND="
	abc? ( dev-vcs/git )
	clang? ( sys-devel/clang )
	sys-devel/make
	sys-devel/bison
	sys-devel/flex
	sys-apps/gawk
	virtual/pkgconfig
	$RDEPEND
"

S="${WORKDIR}/${PN}-${P}"

src_prepare() {
	ln -s ${WORKDIR}/abc-${ABC_GIT_COMMIT} ${S}/abc
	eapply_user
}

src_configure() {
	(
	    echo "CONFIG := `usex clang clang gcc`"
	    echo "ENABLE_TCL := `usex tcl 1 0`"
	    echo "ENABLE_ABC := `usex abc 1 0`"
	    echo "ENABLE_PLUGINS := `usex plugins 1 0`"
	    echo "ENABLE_READLINE := `usex readline 1 0`"
	    echo "ABCREV=default"
		echo "ABCPULL=0"
		echo "PREFIX=/usr"
		echo "DESTDIR=\"${D}\""
	    if ! has_version sys-apps/gawk ; then
	        echo "PRETTY := 0"
	    fi
	) > Makefile.conf
}

src_compile() {
	emake
}

src_install() {
	emake install
}
