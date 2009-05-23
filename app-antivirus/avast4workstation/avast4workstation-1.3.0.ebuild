# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="avast! Linux Home Edition"
HOMEPAGE="http://www.avast.com/eng/avast-for-linux-workstation.html"
SRC_URI="http://files.avast.com/files/linux/${P}.tar.gz"

LICENSE="Alwil"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="gtk kde"

DEPEND="sys-libs/glibc
	sys-libs/zlib
	gtk? (  >=x11-base/xorg-x11-7.0
		net-libs/libesmtp )"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

LANGS="am az bg bs cs da el en_GB es eu fi ga gu hi hu is ja lt mk ms ne nn pl pt_BR ru sk sq sv tl uk wa zh_TW ar be bn ca cy de eo et fa fr gl he hr id it ko lv mn nb nl no pa pt ro rw sl sr sr@Latn ta tr vi xh zh_CN"

for i in ${LANGS}; do
	IUSE="${IUSE} linguas_${i}"
done

BASE="/opt/avast4"

src_install() {
	#files not needed for cli-only install
	GUIFILES="lib/${PN}/lib-gtk2
		lib/${PN}/lib-x11
		lib/${PN}/share/avast
		lib/${PN}/etc
		lib/${PN}/bin/avastgui
		bin/avastgui"

	doman share/man/man1/*
	rm -r share/man


	if ! use gtk; then
		for i in ${GUIFILES}; do
			rm -r ${i}
		done
	fi

	for n in $(ls lib/avast4workstation/share/locale/) ; do
		if ! use linguas_${n} ; then
			rm -rf lib/avast4workstation/share/locale/"${n}" || die
		fi
	done

	rm -f lib/avast4workstation/lib/libavastengine-4.so.7 || die

	dodir ${BASE}
	mv * "${D}/${BASE}"

	dosym "${BASE}"/lib/avast4workstation/lib/libavastengine-4.so.7.0.5	/usr/lib/libavastengine-4.so.7

	#icons
	if use gtk; then
		desktop="${BASE}"/lib/avast4workstation/share/avast/desktop
		icons="${BASE}"/lib/avast4workstation/share/avast/icons

		dodir /usr/share/applications
		dodir /usr/share/icons/hicolor/48x48/apps
		dodir /usr/share/pixmaps

		dosym $desktop/avast.desktop /usr/share/applications
		dosym $icons/avast-appicon.png /usr/share/icons/hicolor/48x48/apps/avastgui.png
		dosym $icons/avast-appicon.png /usr/share/pixmaps/avastgui.png
	fi

	if use kde ; then
		for kde in /usr/kde/* ; do
			dodir $kde/share/applications
			dodir $kde/share/apps/konqueror/servicemenus
			dodir $kde/share/icons/hicolor/48x48/apps
			dosym $desktop/avast.desktop $kde/share/applications
			dosym $desktop/avast-quickscan.desktop $kde/share/apps/konqueror/servicemenus
			dosym $icons/avast-appicon.png $kde/share/icons/hicolor/48x48/apps/avastgui.png
		done
	fi

	# Setup environment to include our bin directory in the PATH
	dodir /etc/env.d
	echo "PATH=${BASE}/bin" >> ${D}/etc/env.d/93avast4
	echo "ROOTPATH=${BASE}/bin" >> ${D}/etc/env.d/93avast4
}

