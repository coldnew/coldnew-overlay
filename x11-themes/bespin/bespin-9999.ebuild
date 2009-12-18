# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect/eselect-9999.ebuild,v 1.2 2009/04/28 09:50:12 ulm Exp $

EAPI=2

MY_PN="cloudcity"
ESVN_REPO_URI="https://cloudcity.svn.sourceforge.net/svnroot/${MY_PN}"

inherit subversion

DESCRIPTION="Style for Qt4, derived from the Style for the Oxygen project"
HOMEPAGE="http://sourceforge.net/projects/cloudcity/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="kde"

DEPEND="dev-util/cmake"

RDEPEND="x11-libs/qt-core:4
        kde? ( =kde-base/kdelibs-4* )"

S="${WORKDIR}/${MY_PN}"
BUILD_DIR=""
use kde && BUILD_DIR="build"

src_configure() {
	cd ${S} || die "cd ${S} failed"
	if use kde ; then
		mkdir build
		cd build
		cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` -DCMAKE_BUILD_TYPE=Release .. || die "cmake failed"
	else
		eqmake4 qmake.pro || die "eqmake4 failed"
	fi
}

src_compile() {
	cd ${S}/${BUILD_DIR}
	emake
}

src_install() {
	cd "${S}/${BUILD_DIR}"
	emake DESTDIR="${D}" install || die "make install failed"
}
