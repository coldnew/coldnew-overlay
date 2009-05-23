# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
##
## Created by Wolfram Schlich <wschlich@gentoo.org>
##
## TODO
## - ?
##

inherit eutils pax-utils

DESCRIPTION="AVIRA WebGate HTTP/FTP proxy virus scanner"
MY_P="${PN}-prof-${PV/_p/-}"
SRC_URI="http://dl.antivir.de/down/unix/packages/${MY_P}.tar.gz"
HOMEPAGE="http://www.avira.com/"
LICENSE="AVIRA-AntiVir"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND=">=app-antivirus/antivir-core-2.1.12_p19"
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
AVSPOOLDIR="${AVSPOOLDIR:-/var/spool/avwebgate}"
AVTMPDIR="${AVTMPDIR:-/var/tmp}"
AVPIDDIR="${AVPIDDIR:-/var/tmp}"
AVUSER="${AVUSER:-avgate}"
AVUID="${AVUID:-220}"
AVSH="${AVSH:--1}"
AVGROUP="${AVGROUP:-antivir}"
AVGID="${AVGID:-220}"
AVHOSTNAME="${AVHOSTNAME:-$(hostname -f)}"

pkg_setup() {

	#
	# Add USER + GROUP
	#

	enewgroup "${AVGROUP}" "${AVGID}"
	enewuser "${AVUSER}" "${AVUID}" "${AVSH}" -1 "${AVGROUP}" -c AntiVir

}

src_install() {

	#
	# Executables, libraries and misc components
	#

	exeinto "${AVHOMEDIR}"
	exeopts -oroot -g"${AVGROUP}" -m2750
	doexe bin/linux_glibc22/avwebgate.bin
	diropts ""
	dodir \
		"${DESTTREE}/sbin"
	dosym "${AVHOMEDIR}/avwebgate.bin" "${DESTTREE}/sbin/avwebgate"

	#
	# Init script
	#

	exeopts -oroot -groot -m0755
	exeinto /etc/init.d
	newexe "${FILESDIR}/${PV}/antivir-webgate.init.d" antivir-webgate

	#
	# Config
	#

	insopts -oroot -g"${AVGROUP}" -m0640
	insinto "${AVCONFDIR}"
	doins \
		"${FILESDIR}"/${PV}/avwebgate.conf
#	use gui && doins etc/avwebgate.conf-gui
	dosed "s:%AVHOMEDIR%:${AVHOMEDIR}:g" "${AVCONFDIR}/avwebgate.conf"
	dosed "s:%AVCONFDIR%:${AVCONFDIR}:g" "${AVCONFDIR}/avwebgate.conf"
	dosed "s:%AVSPOOLDIR%:${AVSPOOLDIR}:g" "${AVCONFDIR}/avwebgate.conf"
	dosed "s:%AVTMPDIR%:${AVTMPDIR}:g" "${AVCONFDIR}/avwebgate.conf"
	dosed "s:%AVPIDDIR%:${AVPIDDIR}:g" "${AVCONFDIR}/avwebgate.conf"
	dosed "s:%AVUSER%:${AVUSER}:g" "${AVCONFDIR}/avwebgate.conf"
	dosed "s:%AVGROUP%:${AVGROUP}:g" "${AVCONFDIR}/avwebgate.conf"
	dosed "s:%AVHOSTNAME%:${AVHOSTNAME}:g" "${AVCONFDIR}/avwebgate.conf"
	touch "${T}/avwebgate.acl"
	doins "${T}/avwebgate.acl"

	#
	# Spool directory
	#

	diropts -o"${AVUSER}" -g"${AVGROUP}" -m0700
	dodir "${AVSPOOLDIR}"
	keepdir "${AVSPOOLDIR}"
	for dir in quarantine; do
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
		doc/MANUAL \
		doc/RELEASE_NOTES \
		doc/avwebgate_de.pdf \
		doc/avwebgate_en.pdf \
		doc/avwebgate.acl.example \
		legal/LICENSE.*

	#
	# Templates
	#

	diropts ""
	dodir "${AVHOMEDIR}/avwebgate.tpl"
	insopts -m0644
	insinto "${AVHOMEDIR}/avwebgate.tpl"
	doins templates/en/*

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
	einfo "\trc-update add antivir-webgate default"
	einfo ""
	einfo "...and your're done."
	einfo ""

	#
	# Templates
	#

	echo
	einfo ""
	einfo "Using the HTML templates"
	einfo "========================"
	einfo ""
	einfo "The templates were installed into"
	einfo ""
	einfo "\t${AVHOMEDIR}/avwebgate.tpl"
	einfo ""

}
