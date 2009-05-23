# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
##
## Created by Wolfram Schlich <wschlich@gentoo.org>
##
## TODO
## - install: shutdown running programs?
## - install: show EULA?!
## - config: setup avmailgate.acl?
## - install/config: copy keyfile?
## - config: setup mta config? -> show INSTALL.$mta file, at least
## - install/config: avguard? -> check if avspooldir is excluded in guard config
## - install/config: gui?
##

inherit eutils pax-utils

DESCRIPTION="AVIRA AntiVir MailGate SMTP mail virus scanner"
MY_P="${PN}-prof-${PV/_p/-}"
SRC_URI="http://dl1.pro.antivir.de/package/mailgate/unix/en/${PN}-prof.tgz"
HOMEPAGE="http://www.avira.com/"
LICENSE="AVIRA-AntiVir"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="postfix spamfilter" # TODO: gui exim qmail sendmail smc
DEPEND=""
RDEPEND=">=app-antivirus/antivir-savapi-3
	postfix? ( mail-mta/postfix )"
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
AVSPOOLDIR="${AVSPOOLDIR:-/var/spool/avmailgate}"
AVTMPDIR="${AVTMPDIR:-/var/tmp}"
AVPIDDIR="${AVPIDDIR:-/var/tmp}"
AVSAVAPISOCKET="${AVSAVAPISOCKET:-/var/run/avmailgate/scanner}"
AVUSER="${AVUSER:-avgate}"
AVUID="${AVUID:-220}"
AVSH="${AVSH:--1}"
AVGROUP="${AVGROUP:-antivir}"
AVGID="${AVGID:-220}"
AVHOSTNAME="${AVHOSTNAME:-$(hostname -f)}"

#
# Standard ebuild functions
#

pkg_setup() {

	#
	# Add USER + GROUP
	#

	enewgroup "${AVGROUP}" "${AVGID}"
	enewuser "${AVUSER}" "${AVUID}" "${AVSH}" -1 "${AVGROUP}" -c AntiVir

}

src_unpack() {

	unpack ${A}
	cd "${S}"

	#
	# MTA specific config	
	#

	if use postfix; then
		pushd ./etc >/dev/null \
			&& epatch "${FILESDIR}/${PV}/avmailgate.conf.diff.postfix.bz2" \
			&& popd >/dev/null
	fi
	
	#
	# scanner config
	#

	pushd ./etc >/dev/null \
		&& epatch "${FILESDIR}/${PV}/avmailgate-scanner.conf.diff.bz2" \
		&& popd >/dev/null

}

src_install() {

	#
	# Base directories
	#

	if use spamfilter; then
		diropts -oroot -g"${AVGROUP}" -m0750
		dodir /var/tmp/AntiVir
		diropts -o"${AVUSER}" -g"${AVGROUP}" -m0750
		dodir /var/tmp/AntiVir/asmailgate
		diropts ""
	fi

	#
	# Executables, libraries and misc components
	#

	exeinto "${AVHOMEDIR}"
	exeopts -oroot -g"${AVGROUP}" -m2750
	doexe bin/linux_glibc22/avmailgate.bin
	exeopts -oroot -g"${AVGROUP}" -m0750
	newexe script/avira_start.sh.template avmailgate
	doexe script/avmailgate_start.sh
	doexe script/avmailgate_stop.sh
	doexe script/avmailgate_restart.sh
	doexe script/avmailgate_post.sh
	diropts ""
	dodir "${DESTTREE}/sbin"
	dosym "${AVHOMEDIR}/avmailgate.bin" "${DESTTREE}/sbin/avmailgate"
	if use spamfilter; then
		exeopts -o"${AVUSER}" -g"${AVGROUP}" -m2750
		exeinto "${AVHOMEDIR}"
		doexe contrib/asmailgate/bin/linux_glibc22/avmg_ext_filter.bin
		insopts -o"${AVUSER}" -g"${AVGROUP}" -m0644
		insinto "${AVHOMEDIR}"
		doins contrib/asmailgate/bin/linux_glibc22/libasmailgate.so
		doins contrib/asmailgate/data/asmailgate.dat
	fi

	#
	# Init script
	#

	exeopts -oroot -groot -m0755
	exeinto /etc/init.d
	newexe "${FILESDIR}/${PV}/antivir-mailgate.initd" antivir-mailgate

	#
	# Config
	#

	insopts -oroot -g"${AVGROUP}" -m0640
	insinto "${AVCONFDIR}"
	doins \
		etc/avmailgate.acl \
		etc/avmailgate.conf \
		etc/avmailgate.ignore \
		etc/avmailgate.scan \
		etc/avmailgate.warn
#	use gui && doins etc/avmailgate.conf-gui
	dosed "s:%AVHOMEDIR%:${AVHOMEDIR}:g" "${AVCONFDIR}/avmailgate.conf"
	dosed "s:%AVCONFDIR%:${AVCONFDIR}:g" "${AVCONFDIR}/avmailgate.conf"
	dosed "s:%AVSPOOLDIR%:${AVSPOOLDIR}:g" "${AVCONFDIR}/avmailgate.conf"
	dosed "s:%AVTMPDIR%:${AVTMPDIR}:g" "${AVCONFDIR}/avmailgate.conf"
	dosed "s:%AVPIDDIR%:${AVPIDDIR}:g" "${AVCONFDIR}/avmailgate.conf"
	dosed "s:%AVSAVAPISOCKET%:${AVSAVAPISOCKET}:g" "${AVCONFDIR}/avmailgate.conf"
	dosed "s:%AVUSER%:${AVUSER}:g" "${AVCONFDIR}/avmailgate.conf"
	dosed "s:%AVGROUP%:${AVGROUP}:g" "${AVCONFDIR}/avmailgate.conf"
	dosed "s:%AVHOSTNAME%:${AVHOSTNAME}:g" "${AVCONFDIR}/avmailgate.conf"

	doins etc/avmailgate-scanner.conf
	dosed "s:%AVTMPDIR%:${AVTMPDIR}:g" "${AVCONFDIR}/avmailgate-scanner.conf"
	dosed "s:%AVSAVAPISOCKET%:${AVSAVAPISOCKET}:g" "${AVCONFDIR}/avmailgate-scanner.conf"
	dosed "s:%AVUSER%:${AVUSER}:g" "${AVCONFDIR}/avmailgate-scanner.conf"
	dosed "s:%AVGROUP%:${AVGROUP}:g" "${AVCONFDIR}/avmailgate-scanner.conf"

	if use spamfilter; then
		dosed "s:^EnableSpamCheck NO:EnableSpamCheck YES:g" "${AVCONFDIR}/avmailgate.conf"
		touch "${T}/asmailgate.except"
		doins "${T}/asmailgate.except"
	fi

	#
	# Spool directory
	#

	diropts -o"${AVUSER}" -g"${AVGROUP}" -m0700
	dodir "${AVSPOOLDIR}"
	keepdir "${AVSPOOLDIR}"
	for dir in incoming outgoing rejected; do
		dodir "${AVSPOOLDIR}/${dir}"
		keepdir "${AVSPOOLDIR}/${dir}"
	done

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
		doc/INSTALL \
		doc/INSTALL.DE \
		doc/MANUAL \
		doc/RELEASE_NOTES \
		doc/avmailgate_en.pdf \
		legal/LICENSE.*
	use postfix && dodoc \
		doc/INSTALL.postfix
#	use exim && dodoc \
#		doc/INSTALL.exim
#	use sendmail && dodoc \
#		doc/INSTALL.sendmail
#	use qmail && dodoc \
#		doc/INSTALL.qmail
#	use qmail && use gui && dodoc \
#		doc/INSTALL.qmail.gui
	doman \
		doc/man/avmailgate.8 \
		doc/man/avmailgate.conf.5

	#
	# Templates
	#

	diropts ""
	dodir "${AVHOMEDIR}/templates.sample"
	insopts ""
	insinto "${AVHOMEDIR}/templates.sample"
	doins \
		templates/en/patho-administrator \
		templates/en/patho-recipient \
		templates/en/patho-sender \
		templates/en/alert-administrator \
		templates/en/alert-recipient \
		templates/en/alert-sender
	if use spamfilter; then
		doins \
			templates/spamfilter-subjects
	fi

}

pkg_preinst() {

	#
	# Check for legacy files
	#

	# Templates: virus-* -> alert-*
	for t in administrator recipient sender; do
		tf="${AVHOMEDIR}/templates/virus-${t}"
		new_tf="${AVHOMEDIR}/templates/alert-${t}"
		if [ -e "${tf}" ]; then
			ewarn
			ewarn "You have an old notification mail template file in ${AVHOMEDIR}/templates/:"
			ewarn " -> ${tf}"
			ewarn "Please rename it as follows:"
			ewarn " -> ${new_tf}"
			ewarn
		fi
	done

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
	einfo ""
	echo

}

pkg_config() {

	#
	# Init script
	#

	echo
	einfo ""
	einfo "Using the init script"
	einfo "====================="
	einfo ""
	einfo "Simply run..."
	einfo ""
	einfo "\trc-update add antivir-mailgate default"
	einfo ""
	einfo "...and your're done."
	einfo ""

	#
	# Templates
	#

	echo
	einfo ""
	einfo "Using the notification mail templates"
	einfo "====================================="
	einfo ""
	einfo "The sample templates were installed into"
	einfo ""
	einfo "\t${AVHOMEDIR}/templates.sample"
	einfo ""
	einfo "To use them, simply do..."
	einfo ""
	einfo "\tcd ${AVHOMEDIR}"
	einfo "\tmv templates.sample templates"
	einfo ""
	einfo "...and edit the files in the 'templates'-subdirectory."
	einfo ""

	#
	# MTA config
	# TODO: qmail exim sendmail
	#

	if use postfix; then
		echo
		einfo ""
		einfo "MTA configuration (Postfix)"
		einfo "==========================="
		einfo ""
		einfo "See INSTALL.postfix. Quickstart:"
		einfo ""
		einfo "1) Add the following line to /etc/postfix/main.cf:"
		einfo ""
		einfo "\tcontent_filter = smtp:127.0.0.1:10024"
		einfo ""
		einfo "2) Add the following line to /etc/postfix/master.cf:"
		einfo ""
		einfo "\tlocalhost:10025 inet n - y - - smtpd -o content_filter="
		einfo ""
	fi

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
	einfo "\t${min} * * * * root exec ${AVHOMEDIR}/avupdate --product=mailgate >/dev/null"
	einfo ""
	echo

}
