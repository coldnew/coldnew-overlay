EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10} )
inherit eutils python-any-r1

DESCRIPTION="Yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="http://www.clifford.at/icestorm/"
SRC_URI="https://github.com/YosysHQ/${PN}/archive/refs/tags/${P}.tar.gz"
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

src_configure() {
	(
	    echo "CONFIG := `usex clang clang gcc`"
	    echo "ENABLE_TCL := `usex tcl 1 0`"
	    echo "ENABLE_ABC := `usex abc 1 0`"
	    echo "ENABLE_PLUGINS := `usex plugins 1 0`"
	    echo "ENABLE_READLINE := `usex readline 1 0`"
	    if ! has_version sys-apps/gawk ; then
	        echo "PRETTY := 0"
	    fi
	) > Makefile.conf
}

src_compile() {
	emake PREFIX="/usr" || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install
}
