# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2 autotools

DESCRIPTION="Vala binding-generator for xml introspection files"
HOMEPAGE="http://wiki.freesmartphone.org/index.php/Implementations/vala-dbus-binding-tool"
EGIT_REPO_URI="git://git.freesmartphone.org/vala-dbus-binding-tool.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-libs/glib-2.32.0
        >=dev-libs/libgee-0.6.7"

DEPEND="${RDEPEND}
        >=dev-lang/vala-0.18.1"

src_configure() {
        ./autogen.sh
        econf
}
