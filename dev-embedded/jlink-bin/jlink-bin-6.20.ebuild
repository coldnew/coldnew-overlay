# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils unpacker

case ${ARCH} in
				x86)   MY_ARCH="i386"   ;;
				amd64) MY_ARCH="x86_64" ;;
esac

INSTALLDIR="/opt/${PN/-bin/}"

DESCRIPTION="J-Link gdb-server and commander for Segger J-Link jtag adapter"
HOMEPAGE="http://www.segger.com/jlink-software.html"
SRC_URI="amd64? ( JLink_Linux_V${PV/./}_x86_64.deb )
				 x86? ( JLink_Linux_V${PV/./}_i386.deb )"

LICENSE="J-Link Terms of Use"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
QA_PREBUILT="*"

RESTRICT="fetch strip"
DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/libedit"

S=${WORKDIR}

pkg_nofetch() {
		einfo "Segger requires you to download the needed files manually after"
		einfo "accepting their license through a javascript capable web browser."
		einfo
		einfo "Please download the files from Segger's jlink download archive:"
		einfo
		einfo "   https://www.segger.com/downloads/jlink/JLink_Linux_V${PV/./}_${MY_ARCH}.deb"
		einfo ""
}

src_unpack() {
		unpack_deb "${A}"
}

src_install() {
		# install /opt
		insinto /opt/SEGGER
		insopts -m 0755
		doins -r ${S}/opt/SEGGER/* || die "doins /opt failed"

		# install usr
		insinto /usr/bin
		insopts -m 0755
		doins -r usr/bin/* || die "doins /usr/bin failed"

		# install etc
		insinto /lib/udev/rules.d/
		doins etc/udev/rules.d/99-jlink.rules || die "doins udev rules failed"
}

pkg_postinst() {
		enewgroup plugdev
		elog "To be able to access the jlink usb adapter, you have to be"
		elog "a member of the 'plugdev' group."
}
