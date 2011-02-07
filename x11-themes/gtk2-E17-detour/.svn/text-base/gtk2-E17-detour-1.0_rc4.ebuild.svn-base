# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="GTK2 theme to match the E17 Detour theme"
HOMEPAGE="http://www.gnome-look.org/content/show.php?content=81769"
SRC_URI="http://www.gnome-look.org/CONTENT/content-files/81769-detour-RC4.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="x11-themes/gtk-engines-aurora"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/themes
	doins -r Detour-RC4 || die
}
