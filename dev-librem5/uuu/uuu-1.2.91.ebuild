# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

if [[ ${PV} == *9999 ]] ; then
    SCM="git-r3"
    EGIT_REPO_URI="https://source.puri.sm/Librem5/mfgtools"
fi

inherit eutils ${SCM} cmake-utils udev

DESCRIPTION="This is a copy of the Freescale/NXP I.MX Chip image deploy tools for librem-5."
HOMEPAGE="https://arm01.puri.sm/job/debs/job/deb-mfgtools-buster-amd64/"


if [[ ${PV} == *9999 ]] ; then
   SRC_URI=""
else
   SRC_URI="https://source.puri.sm/Librem5/mfgtools/-/archive/${PN}_${PV}/mfgtools-${PN}_${PV}.tar.gz"
   S="${WORKDIR}/mfgtools-${PN}_${PV}"
fi

LICENSE="BSD-3"
SLOT="0"
KEYWORDS=" ~amd64"
IUSE=""

DEPEND="
  dev-libs/libzip
  dev-libs/libusb
"
RDEPEND="${DEPEND}"

if [[ ${PV} != *9999 ]] ; then
   src_prepare() {
      epatch "${FILESDIR}/0001-libuuu-remove-gitversion.h.patch"
      # already includes epatch_user:
      cmake-utils_src_prepare
  }
fi

src_install() {
    # systemd stuff
    udev_newrules "${FILESDIR}/99_librem5_devkit.rules" 99_librem5_devkit.rules
    cmake-utils_src_install
}

pkg_postinst() {
    enewgroup plugdev
    elog "To be able to access the librem5's uuu command, you have to be"
    elog "a member of the 'plugdev' group."
}
