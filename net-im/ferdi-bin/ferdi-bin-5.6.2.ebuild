# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

_PN="${PN/-bin/}"

inherit desktop xdg-utils

DESCRIPTION="Combine your favorite messaging services into one application"
HOMEPAGE="https://getferdi.com"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64"
SRC_URI="
amd64? ( https://github.com/get${_PN}/${_PN}/releases/download/v${PV}/${_PN}_${PV}_amd64.deb )
arm? ( https://github.com/get${_PN}/${_PN}/releases/download/v${PV}/${_PN}_${PV}_armv7l.deb )
arm64? ( https://github.com/get${_PN}/${_PN}/releases/download/v${PV}/${_PN}_${PV}_arm64.deb )"

RDEPEND="
media-libs/alsa-lib
net-dns/c-ares
media-video/ffmpeg
x11-libs/gtk+:3
dev-python/http-parser
dev-libs/libevent
net-libs/nghttp2
app-crypt/libsecret
x11-libs/libxkbfile
dev-libs/libxslt
x11-libs/libXScrnSaver
x11-libs/libXtst
sys-libs/zlib[minizip]
dev-libs/nss
dev-libs/re2
app-arch/snappy"

DEPEND="!net-im/ferdi"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	bsdtar -x -f data.tar.xz
	rm data.tar.xz control.tar.gz debian-binary
	sed -E -i -e "s|Exec=/opt/${_PN^}/${_PN}|Exec=/usr/bin/${PN}|" "usr/share/applications/${_PN}.desktop"
	default
}

src_install() {
	declare FERDI_HOME=/opt/${_PN}

	dodir ${FERDI_HOME%/*}

	insinto ${FERDI_HOME}
	doins -r opt/${_PN^}/*

	exeinto ${FERDI_HOME}
	exeopts -m0755
	doexe "opt/${_PN^}/${_PN}"

	dosym "${FERDI_HOME}/${_PN}" "/usr/bin/${PN}"

	newmenu usr/share/applications/${_PN}.desktop ${PN}.desktop

	for _size in 16 24 32 48 64 96 128 256 512; do
		newicon -s ${_size} "usr/share/icons/hicolor/${_size}x${_size}/apps/${_PN}.png" "${PN}.png"
	done

	# desktop eclass does not support installing 1024x1024 icons
	insinto /usr/share/icons/hicolor/1024x1024/apps
	newins "usr/share/icons/hicolor/1024x1024/apps/${_PN}.png" "${PN}.png"

	# Installing 128x128 icon in /usr/share/pixmaps for legacy DEs
	newicon "usr/share/icons/hicolor/128x128/apps/${_PN}.png" "${PN}.png"

	insinto /usr/share/licenses/${PN}
	for _license in 'LICENSE.electron.txt' 'LICENSES.chromium.html'; do
	doins opt/${_PN^}/$_license
	done
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
