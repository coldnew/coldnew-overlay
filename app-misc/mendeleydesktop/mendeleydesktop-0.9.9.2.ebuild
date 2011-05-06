# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=2

inherit eutils

if [ "${ARCH}" = "amd64" ] ; then
        LNXARCH="linux-x86_64"
else
        LNXARCH="linux-i486"
fi

DESCRIPTION="A free research management tool for desktop & web"
HOMEPAGE="http://www.mendeley.com/"
SRC_URI="http://www.mendeley.com/downloads/linux/${P}-${LNXARCH}.tar.bz2"

LICENSE="Mendelay-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"
RDEPEND=""

S="${WORKDIR}/${P}-${LNXARCH}"

MENDELEY_INSTALL_DIR="/opt/${PN}"

src_install() {
	# install menu
	domenu ${S}/share/applications/${PN}.desktop || die "Installing desktop files failed."
	# Install commonly used icon sizes
	for res in 16x16 22x22 32x32 48x48 64x64 128x128 ; do
		insinto /usr/share/icons/hicolor/${res}/apps
		doins share/icons/hicolor/${res}/apps/${PN}.png || die "Installing icons failed."
	done
	insinto /usr/share/pixmaps
	doins share/icons/hicolor/48x48/apps/${PN}.png || die "Installing pixmap failed."


	# dodoc
	dodoc ${S}/share/doc/${PN}/* || die "Installing docs failed."

	dodir ${MENDELEY_INSTALL_DIR}
	dodir ${MENDELEY_INSTALL_DIR}/lib
	dodir ${MENDELEY_INSTALL_DIR}/share
	#mv ${S}/share/icons ${D}/usr/share
	mv ${S}/bin ${D}${MENDELEY_INSTALL_DIR} || die "Installing bin failed."
	mv ${S}/lib ${D}${MENDELEY_INSTALL_DIR} || die "Installing libs failed."
	mv ${S}/share/${PN} ${D}${MENDELEY_INSTALL_DIR}/share || die "Installing shared files failed."

	dosym /opt/${PN}/bin/${PN} /opt/bin/${PN} || die "Installing launcher symlinks failed."

}
