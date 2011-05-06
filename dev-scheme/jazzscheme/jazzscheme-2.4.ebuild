# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="JazzScheme is an open source programming language based on Scheme."
HOMEPAGE="http://www.jazzscheme.org/"

if [ "$PV" = 9999 ]; then
	inherit git
	EGIT_REPO_URI="git://github.com/jazzscheme/jazz.git"
	KEYWORDS=""
else
	GIT_TAG="v$PV"
	SRC_URI="https://github.com/jazzscheme/jazz/tarball/${GIT_TAG} -> ${PN}-git-${PV}.tgz"
	KEYWORDS="~x86 ~amd64"
fi


LICENSE="|| ( MPL-1.1 GPL-2 )"
SLOT="0"
IUSE=""

DEPEND=">=dev-scheme/gambit-4.6.0
          x11-libs/cairo"
RDEPEND="${DEPEND}"

if [ "$PV" != 9999 ]; then
	src_unpack() {
		unpack ${A} || die
		mv "${WORKDIR}/jazzscheme-jazz-"??????? "${S}" || die
	}
fi

src_compile() {
	vecho ">>> Configuring..."
	gsc configure || die
	vecho ">>> Building..."
	gsc make all  || die
	#gsc make jedi jobs: 2 || die
}

src_install() {
	mkdir -p "${D}"/opt/jazzscheme
	mv * "${D}"/opt/jazzscheme
	#gsc make install || die
}
