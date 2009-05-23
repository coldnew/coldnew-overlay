# Copyright 1999-2008 Gentoo Foundation
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

inherit eutils multilib

DESCRIPTION="AVIRA AntiVir virus scanner (core)"
MY_P="${PN/core/workstation}-prof-${PV/_p/-}"
SRC_URI="http://dl.antivir.de/down/unix/packages/${MY_P}.tar.gz
	mirror? ( http://dl.antivir.de/down/unix/mirror.zip )
	smc? ( http://dl.antivir.de/down/unix/packages/antivir-updateplugin-prof-2.1.10.tar.gz )"
HOMEPAGE="http://www.antivir.de/"
LICENSE="AVIRA-AntiVir"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="crypt gui mirror smc"
DEPEND=""
RDEPEND=""
S="${WORKDIR}/${MY_P}"
# prevent installation functions from stripping binaries
# otherwise the antivir selfcheck fails. also don't try
# to fetch the distribution tarball from a mirror.
RESTRICT="strip mirror"

#
# Settings overridable by user supplied environment variables
#

AVHOMEDIR="${AVHOMEDIR:-/usr/lib/AntiVir}"
AVCONFDIR="${AVCONFDIR:-/etc}"
AVGROUP="${AVGROUP:-antivir}"
AVGID="${AVGID:-220}"

#
# Standard ebuild functions
#

pkg_setup() {

	#
	# Add GROUP
	#

	enewgroup "${AVGROUP}" "${AVGID}"

}

src_install () {

	#
	# Home directory
	#

	diropts -oroot -groot -m0755
	dodir "${AVHOMEDIR}"
	diropts -oroot -g"${AVGROUP}" -m0770
	dodir "${AVHOMEDIR}/.storage" "${AVHOMEDIR}/updcomp"
	insinto "${AVHOMEDIR}"
	insopts -oroot -g"${AVGROUP}" -m0644

	#
	# Executables, libraries and misc components
	#

	exeopts -oroot -g"${AVGROUP}" -m2755
	exeinto "${AVHOMEDIR}"
	doexe bin/linux_glibc22/antivir
	diropts ""
	dodir \
		"${DESTTREE}/bin" \
		"${DESTTREE}/sbin"
	dosym "${AVHOMEDIR}/antivir" "${DESTTREE}/bin/antivir"
	if use mirror; then
		exeopts -oroot -g"${AVGROUP}" -m0750
		doexe "${WORKDIR}"/antivir-mirror
	fi

	#
	# VDF
	#

	insinto "${AVHOMEDIR}"
	doins vdf/*.vdf

	#
	# Key file (TODO FIXME)
	#

	if [ -f "${FILESDIR}/hbedv.key" ]; then
		insopts -oroot -g"${AVGROUP}" -m0640
		insinto "${AVHOMEDIR}"
		doins "${FILESDIR}/hbedv.key"
	fi
#	dodir /etc/env.d && echo "CONFIG_PROTECT=\"${AVHOMEDIR}/hbedv.key\"" >"${D}/etc/env.d/99antivir"

	#
	# Config
	#

	insopts -oroot -g"${AVGROUP}" -m0640
	insinto "${AVCONFDIR}"
	doins \
		"${FILESDIR}"/${PV}/avupdater.conf
	if use mirror; then
		newins "${WORKDIR}"/antivir-mirror.conf.default antivir-mirror.conf
	fi

	## TODO:GUI

	## TODO:SMC

	#
	# Documents
	#

	dodoc \
		LICENSE \
		LICENSE.DE \
		README \
		doc/CHANGELOG \
		doc/MANUAL \
		legal/LICENSE.*
	if use crypt; then
		dodoc pgp/antivir.gpg
		newdoc pgp/README README.gpg
	fi
	if use mirror; then
		newdoc "${WORKDIR}"/README README.mirror
		newdoc "${WORKDIR}"/LIESMICH LIESMICH.mirror
		newdoc "${WORKDIR}"/product-types.txt antivir-mirror.product-types.txt
	fi

}

pkg_preinst() {

	#
	# Check for legacy files
	#

	# Updater config: antivir.conf -> avupdater.conf
	if [ -e "${AVCONFDIR}/antivir.conf" ]; then
		ewarn
		ewarn "You have a deprecated antivir.conf in ${AVCONFDIR}/."
		ewarn "Please use ${AVCONFDIR}/avupdater.conf for the AntiVir Updater settings."
		ewarn "A sample avupdater.conf has been installed to ${AVCONFDIR}/avupdater.conf"
		ewarn "Please compare the settings from antivir.conf with those in avupdater.conf,"
		ewarn "modify those in avupdater.conf as needed and remove antivir.conf when done."
		ewarn
	fi

}

pkg_postinst() {

	#
	# Config
	#

	echo
	einfo ""
	einfo "Configuration"
	einfo "============="
	einfo ""
	einfo "Please run..."
	einfo ""
	einfo "\tebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	einfo ""
	einfo "...to configure the package!"

	echo

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
	einfo "\t${min} * * * * root exec ${AVHOMEDIR}/antivir --update >/dev/null"
	einfo ""
	echo

	## TODO: mirror script
}
