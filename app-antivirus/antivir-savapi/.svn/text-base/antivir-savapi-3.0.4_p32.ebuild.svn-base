# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
##
## Created by Wolfram Schlich <wschlich@gentoo.org>
##
## TODO
## - install: shutdown running programs?
## - install: show EULA?!
## - install/config: copy keyfile?
##

inherit eutils

DESCRIPTION="AVIRA AntiVir virus scanner (SAVAPI)"
#MY_P="${PN/savapi/mailgate}-prof-${PV/_p/-}"
MY_P="${PN/savapi/mailgate}-prof-3.0.0-14"
MY_P2="${PN/savapi/mailgate}-prof"
SRC_URI="http://dl1.pro.antivir.de/package/mailgate/unix/en/${MY_P2}.tgz"
#SRC_URI="http://storage.bu.avira.com/pub/savapi/2008.10.07/savapi3-${PV/_p/.}-linux_glibc22.zip"
HOMEPAGE="http://www.avira.com/"
LICENSE="AVIRA-AntiVir"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND=""
S="${WORKDIR}/${MY_P}"
#S="${WORKDIR}"
# prevent installation functions from stripping binaries
# otherwise the antivir selfcheck fails. also don't try
# to fetch the distribution tarball from a mirror.
RESTRICT="strip mirror"

#
# Settings overridable by user supplied environment variables
#

AVHOMEDIR="${AVHOMEDIR:-/usr/lib/AntiVir}"
AVCONFDIR="${AVCONFDIR:-/etc/avira}"
AVTMPDIR="${AVTMPDIR:-/var/tmp}"
#AVSAVAPISOCKET="${AVSAVAPISOCKET:-/var/run/antivir-savapi/scanner}"
#AVUSER="${AVUSER:-avgate}"
#AVUID="${AVUID:-220}"
#AVSH="${AVSH:--1}"
AVGROUP="${AVGROUP:-antivir}"
AVGID="${AVGID:-220}"

#
# Standard ebuild functions
#

pkg_setup() {

	#
	# Add USER + GROUP
	#

	enewgroup "${AVGROUP}" "${AVGID}"
#	enewuser "${AVUSER}" "${AVUID}" "${AVSH}" -1 "${AVGROUP}" -c AntiVir

}

src_unpack() {
	unpack ${A}
	cd "${S}"
#	ln -s . bin; ln -s . linux_glibc22
}

src_install () {

	#
	# Home directory
	#

	diropts -oroot -groot -m0755
	dodir "${AVHOMEDIR}"
	diropts -oroot -g"${AVGROUP}" -m0770
	insinto "${AVHOMEDIR}"
	insopts -oroot -g"${AVGROUP}" -m0644

	#
	# Executables, libraries and misc components
	#

	exeinto "${AVHOMEDIR}"
	exeopts -oroot -g"${AVGROUP}" -m2755
	doexe bin/linux_glibc22/savapi
	doexe bin/linux_glibc22/avupdate.bin
	doexe bin/linux_glibc22/avlinfo
	exeopts -oroot -g"${AVGROUP}" -m0755
	doexe script/savapi3_reload.sh
	doexe script/savapi3_post.sh
	doexe script/avupdate
	doexe script/post_install.sh
	doins bin/linux_glibc22/avupdate_msg.avr
	doins bin/linux_glibc22/ae*.so
	doins bin/linux_glibc22/ae*.dat
	lv=$(cd bin/linux_glibc22; ls -1 libsavapi3.so.*); lv=${lv##*.so.}
	doins bin/linux_glibc22/libsavapi3.so.${lv}
	dosym libsavapi3.so.${lv} "${AVHOMEDIR}"/libsavapi3.so
	diropts ""
	dodir "${DESTTREE}/bin"
	dosym "${AVHOMEDIR}/savapi" "${DESTTREE}/bin/savapi"

	#
	# Init script
	#

#	exeopts -oroot -groot -m0755
#	exeinto /etc/init.d
#	newexe "${FILESDIR}/${PV}/antivir-savapi.initd" antivir-savapi

	#
	# Config
	#

	insopts -oroot -g"${AVGROUP}" -m0640
#	insinto "${AVCONFDIR}"
#	doins "${FILESDIR}"/${PV}/antivir-savapi.conf
#	dosed "s:%AVTMPDIR%:${AVTMPDIR}:g" "${AVCONFDIR}/antivir-savapi.conf"
#	dosed "s:%AVSAVAPISOCKET%:${AVSAVAPISOCKET}:g" "${AVCONFDIR}/antivir-savapi.conf"
#	dosed "s:%AVUSER%:${AVUSER}:g" "${AVCONFDIR}/antivir-savapi.conf"
#	dosed "s:%AVGROUP%:${AVGROUP}:g" "${AVCONFDIR}/antivir-savapi.conf"
	insinto "${AVCONFDIR}"
	doins "${FILESDIR}"/${PV}/avupdate.conf
	dosed "s:%AVHOMEDIR%:${AVHOMEDIR}:g" "${AVCONFDIR}/avupdate.conf"
	dosed "s:%AVTMPDIR%:${AVTMPDIR}:g" "${AVCONFDIR}/avupdate.conf"

}

pkg_config () {

	#
	# Automatic updates
	# Generate a random number between 1 and 59 for the crontab
	#

	rand="$$$(date +%s)"
	min="$[ ($rand % 59) + 1 ]"
	echo
	einfo ""
	einfo "Using the internet updater"
	einfo "=========================="
	einfo ""
	einfo "Add the following line to your /etc/crontab or a new file"
	einfo "in /etc/cron.d/ to make AntiVir check for updates"
	einfo "${min} minutes after every full hour:"
	einfo ""
	einfo "\t${min} * * * * root exec ${AVHOMEDIR}/avupdate --product=scanner >/dev/null"
	einfo ""
	echo

}
