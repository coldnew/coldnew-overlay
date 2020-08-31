EAPI=6

GIT_COMMIT=04f6158bf2ce9a95970f1be435351786f59bed92
S=$WORKDIR/$PN-$GIT_COMMIT

# get the current value from the yosys makefile
ABC_GIT_COMMIT=341db25668f3054c87aa3372c794e180f629af5d

DESCRIPTION="framework for Verilog RTL synthesis"
HOMEPAGE="http://www.clifford.at/yosys/"
SRC_URI="https://github.com/YosysHQ/$PN/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz
	 https://github.com/YosysHQ/abc/archive/$ABC_GIT_COMMIT.tar.gz -> abc-$ABC_GIT_COMMIT.tar.gz"
LICENSE=ISC
SLOT=0
KEYWORDS=

#PATCHES="$FILESDIR/$PN-0.10-makefile-fix.patch"

DEPEND="dev-vcs/git
	media-gfx/xdot
	dev-libs/boost
	sys-devel/clang"

# $FILESDIR/$PN-$PV-deps.tar.gz needs to be updated with the ebuild:
# cd /tmp
# tar xf yosys-tarball.tar.gz
# cd yosys-dir
# tar xf abc-tarball.tar.gz
# mv abc-commit abc
# make config-clang
# make -j16 ABCREV=default ABCPULL=0
# tar czf $FILESDIR/$PN-$PV-deps.tar.gz `find -name \*.d`

src_unpack() {
	unpack $P.tar.gz
	unpack abc-$ABC_GIT_COMMIT.tar.gz
	mv $WORKDIR/abc-$ABC_GIT_COMMIT $S/abc
	cd $S && unpack $FILESDIR/$PN-$PV-deps.tar.gz
}

src_configure() {
	make config-clang
}

src_compile() {
	make DESTDIR="$D" ABCREV=default ABCPULL=0 PREFIX=/usr
}

src_install() {
	make DESTDIR="$D" ABCREV=default ABCPULL=0 PREFIX=/usr install	
}
