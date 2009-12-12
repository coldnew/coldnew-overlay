# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-util/font-util-1.1.1.ebuild,v 1.1 2009/10/12 17:18:59 remi Exp $

inherit x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/xorg/font/util"
DESCRIPTION="X.Org font utilities"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=x11-misc/util-macros-1.3.0"

CONFIGURE_OPTIONS="--with-mapdir=/usr/share/fonts/util --with-fontrootdir=/usr/share/fonts"
