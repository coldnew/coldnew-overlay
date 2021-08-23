EAPI=7
EGIT_COMMIT="dfc453b246c3b211a8c5df5e04c7afe2451b0986"
inherit eutils git-r3

EGIT_REPO_URI="https://github.com/YosysHQ/yosys"
SRC_URI=""
KEYWORDS="~amd64"
LICENSE="ISC"
SLOT="0"
IUSE="tcl +abc plugins readline clang"

RDEPEND="tcl? ( dev-lang/tcl )
         plugins? ( virtual/libffi virtual/pkgconfig )
         readline? ( sys-libs/readline )"
DEPEND="abc? ( dev-vcs/git )
        clang? ( sys-devel/clang )
        sys-devel/flex sys-devel/bison sys-devel/make
        $RDEPEND"

src_unpack() {
    git-r3_src_unpack
    if use abc; then
        cd ${S} || die
        local ABCURL=$(sed -ne '/^ABCURL/s/^.*=//p;T;q' < Makefile)
        local ABCREV=$(sed -ne '/^ABCREV/s/^.*=//p;T;q' < Makefile)
        git clone ${ABCURL} abc || die
        cd abc || die
        ABCREV=${ABCREV//[[:space:]]}
        git config --local core.abbrev ${#ABCREV} || die
        git checkout ${ABCREV} || die
    fi
}

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
