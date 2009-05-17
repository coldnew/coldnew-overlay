# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="An integrated development environment for the GNU Octave programming language"
HOMEPAGE="http://www.math.mcgill.ca/loisel/octave-workshop/"
SRC_URI="http://www.ics.es.yamanashi.ac.jp/mirror/octave-workshop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sci-mathematics/octave-2.1.57
	>=x11-libs/qt-4.1.0"

src_unpack(){
	unpack ${P}.tar.gz
	cd "${S}"
	echo "++++++++++++++++++++++++++++"
	pwd
	sed -i -e "s/static void/extern void/g" embed.cc
	sed -i -e "s/using namespace std;/#include<assert.h>\nusing	namespace std;/g" editwindow.cpp
}

src_compile () {
	econf || die "Configure failed"
	make || die "Make failed"
}

src_install () {
	make install DESTDIR=${D} || die "Install failed"
}
