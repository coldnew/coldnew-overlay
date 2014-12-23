# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Prebuild version of slic3r, a G-code generator for 3D printers"
HOMEPAGE="http://slic3r.org"
SRC_URI="
	amd64?	( http://dl.slic3r.org/linux/slic3r-linux-x86_64-1-2-1-experimental.tar.gz )
	x86?	( http://dl.slic3r.org/linux/slic3r-linux-x86-1-2-1-experimental.tar.gz )"

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/bin/slic3r"

src_unpack() {
	unpack ${A}
	mkdir -p "${S}"
	mv "${WORKDIR}"/Slic3r/* "${S}" || die
	rmdir Slic3r
}

src_install() {
	exeinto "/opt/${PN}"
	cp -ar "${S}"/* "${D}/opt/${PN}" || die "Failed to copy stuff"

	dodir /opt/bin
	dosym ../${PN}/bin/slic3r /opt/bin/slic3r || die
}
