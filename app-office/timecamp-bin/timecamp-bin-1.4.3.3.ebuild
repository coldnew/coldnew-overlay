# Copyright 2017 Yurij Mikhalevich <yurij@mikhalevi.ch>
# Distributed under the terms of the MIT License

EAPI=6

inherit eutils unpacker

DESCRIPTION="Track time and app usage with timecamp.com"
BASE_SERVER_URI="https://www.timecamp.com"
HOMEPAGE="${BASE_SERVER_URI}"
SRC_URI="${BASE_SERVER_URI}/downloadsoft/${PV}/TimeCampSetup_LinAmd64-${PV}.tar.gz -> timecamp-${PV}.tar.gz"

LICENSE="TIMECAMP"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/xz-utils
	dev-db/sqlite
	dev-db/sqlcipher
	dev-libs/libappindicator:2
	media-libs/libpng:1.2
	net-misc/curl
	sys-apps/dbus
	virtual/libudev
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libX11"

S=${WORKDIR}

src_unpack() {
	tar xvf ${DISTDIR}/timecamp-${PV}.tar.gz
	unpack_deb timecamp.deb
}

src_install() {
        rm -rf timecamp-${PV}.tar.gz
	rm -rf install.sh
	rm -rf README.txt
	rm -rf timecamp.deb
	cp -Rp "${S}/"* "${D}"
}