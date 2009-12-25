# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WX_GTK_VER="2.8"

inherit autotools eutils flag-o-matic subversion wxwidgets

DESCRIPTION="Free cross-platform C/C++ IDE"
HOMEPAGE="http://www.codeblocks.org/"
ESVN_REPO_URI="svn://svn.berlios.de/${PN}/trunk"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="contrib debug pch static"

DEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]
	sys-devel/libtool:1.5"
RDEPEND="${DEPEND}"

src_prepare() {
# Let's make the autorevision work.
	subversion_wc_info
	CB_LCD=$(LC_ALL=C svn info "${ESVN_WC_PATH}" | grep "^Last Changed Date:" | cut -d" " -f4,5)
	echo "m4_define([SVN_REV], ${ESVN_WC_REVISION})" > revision.m4
	echo "m4_define([SVN_DATE], ${CB_LCD})" >> revision.m4
	eautoreconf
}

src_configure() {
# C::B is picky on CXXFLAG -fomit-frame-pointer
# (project-wizard crash, instability ...)
	filter-flags -fomit-frame-pointer
	append-flags -fno-strict-aliasing

	local myconf=""
	use contrib && myconf="--with-contrib-plugins=all"
	econf --with-wx-config="${WX_CONFIG}" --disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable static) \
		$(use_enable pch) \
		${myconf}
}

src_compile() {
	emake clean-zipfiles || die '"emake clean-zipfiles" failed...'
	emake || die "Died in action: emake ..."
}

src_install() {
	emake DESTDIR="${D}" install || die "Died in action: emake install ... "
}
