# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

MY_P="${P/_p*}"
CHAPPA_VERSION="${PV/*_p}"
CHAPPA_PATCH="${MY_P}-chappa-all-${CHAPPA_VERSION}.patch"

DESCRIPTION="alternativly licensed pine with full UTF-8 support"
HOMEPAGE="http://www.washington.edu/alpine/
	http://staff.washington.edu/chappa/alpine/"
SRC_URI="ftp://ftp.cac.washington.edu/alpine/${MY_P}.tar.bz2
	chappa? (
		http://staff.washington.edu/chappa/alpine/patches/${MY_P}/all_${CHAPPA_VERSION}.patch.gz -> ${CHAPPA_PATCH}.gz
		http://dev.gentoo.org/~swegener/distfiles/${CHAPPA_PATCH}.gz
	)"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+chappa debug doc ipv6 kerberos ldap nls spell ssl threads onlyalpine passfile"

DEPEND="virtual/pam
	>=sys-libs/ncurses-5.1
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( app-crypt/mit-krb5 )
	spell? ( app-text/aspell )"
RDEPEND="${DEPEND}
	app-misc/mime-types
	!onlyalpine? (
		!app-editors/pico
		!mail-client/pine
	)
	!<=net-mail/uw-imap-2004g"

S="${WORKDIR}"/${MY_P}

maildir_warn() {
	einfo
	einfo "This build of alpine has Maildir support built in as"
	einfo "part of the chappa-all patch."
	einfo
	einfo "If you have a maildir at ~/Maildir it will be your"
	einfo "default INBOX. The path may be changed with the"
	einfo "\"maildir-location\" setting in alpine."
	einfo
	einfo "To use /var/spool/mail INBOX again, set"
	einfo "\"disable-these-drivers=md\" in your .pinerc file."
	einfo
	einfo "Alternately, you might want to read following webpage, which explains how to"
	einfo "use multiple mailboxes simultaneously:"
	einfo
	einfo "http://staff.washington.edu/chappa/alpine/alpine-info/collections/incoming-folders/"
	einfo
}

pkg_setup() {
	use chappa && maildir_warn
}

src_unpack() {
	default_src_unpack

	use chappa && epatch "${WORKDIR}"/${CHAPPA_PATCH}
}

src_configure() {
	econf \
		--with-system-pinerc=/etc/pine.conf \
		--with-system-fixed-pinerc=/etc/pine.conf.fixed \
		--without-tcl \
		$(use_with ssl) \
		$(use_with ssl ssl-certs-dir /etc/ssl/certs) \
		$(use_with ldap) \
		$(use_with passfile passfile .pinepwd) \
		$(use_with kerberos krb5) \
		$(use_with threads pthread) \
		$(use_with spell simple-spellcheck) \
		$(use_with spell interactive-spellcheck) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_enable ipv6) \
		|| die "econf failed"
}

src_install() {
	if use onlyalpine
	then
		dobin alpine/alpine
		doman doc/alpine.1
	else
		emake DESTDIR="${D}" install || die "emake install failed"

		doman doc/rpdump.1 doc/rpload.1
	fi

	dodoc NOTICE
	use chappa && dodoc README.maildir

	if use doc
	then
		dodoc README doc/brochure.txt doc/tech-notes.txt

		docinto imap
		dodoc imap/docs/*.txt imap/docs/CONFIG imap/docs/RELNOTES

		docinto imap/rfc
		dodoc imap/docs/rfc/*.txt

		docinto html/tech-notes
		dohtml -r doc/tech-notes/
	fi
}

pkg_postinst() {
	if use spell
	then
		elog "In order to use spell checking"
		elog "  emerge app-dicts/aspell-\<your_langs\>"
		elog "and setup alpine with:"
		elog "  Speller = /usr/bin/aspell -c"
		elog
	fi
}
