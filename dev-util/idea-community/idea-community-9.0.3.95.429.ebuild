# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

SLOT="$(get_major_version)"
RDEPEND=">=virtual/jdk-1.6"

MY_PV="$(get_version_component_range 4-5)"
MY_PN="idea"

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

DESCRIPTION="IntelliJ IDEA is an intelligent Java IDE"
HOMEPAGE="http://jetbrains.com/idea/"
SRC_URI="http://download.jetbrains.com/${MY_PN}/${MY_PN}IC-$(get_version_component_range 1-3).tar.gz"
LICENSE="IntelliJ-IDEA"
IUSE=""
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/${MY_PN}-IC-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unzip lib/icons.jar icon_CE.png
}

src_install() {
	local dir="/opt/${P}"
	local exe=${MY_PN}-${SLOT}
	local icon=${exe}
	newicon "icon_CE.png" ${icon}.png
	rm "icon_CE.png"
	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${MY_PN}.sh"
	dodir /usr/bin
	make_wrapper "$exe" "/opt/${P}/bin/${MY_PN}.sh"
	make_desktop_entry ${exe} "IntelliJ IDEA ${PV}" ${icon} "Development;IDE"
}
