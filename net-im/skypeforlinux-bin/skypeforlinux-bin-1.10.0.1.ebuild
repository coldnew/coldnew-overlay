# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils  unpacker

DESCRIPTION="Skype for Linux WebRTC Alpha"
HOMEPAGE="http://www.skype.com/"
SRC_URI="https://repo.skype.com/deb/pool/main/s/skypeforlinux/skypeforlinux_${PV}_amd64.deb"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE=""

RESTRICT="mirror bindist strip" #299368

DEPEND="x11-libs/gtk+
        media-libs/alsa-lib
        x11-libs/libXtst"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
    unpack_deb "${A}"
}

src_install() {
    insinto /usr
    insopts -m 0755
    doins -r ${S}/usr/*
}
