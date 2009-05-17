# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gwave/gwave-20070514.ebuild,v 1.4 2007/11/25 17:03:02 calchan Exp $

MY_P="${PN}-${PV}"
DESCRIPTION="Analog waveform viewer for SPICE-like simulations"
LICENSE="GPL-2"
HOMEPAGE="http://www.geda.seul.org/tools/gwave/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~ppc ~x86 ~amd64"
IUSE="gnuplot plotutils"
SLOT="0"

DEPEND="=dev-scheme/guile-1.8*
	>=x11-libs/guile-gtk-2.0
	dev-scheme/guile-gnome-platform"
RDEPEND="${DEPEND}
	gnuplot? ( sci-visualization/gnuplot )
	plotutils? ( media-libs/plotutils )"

S="${WORKDIR}/${MY_P}"


src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	rm -f doc/Makefile* *.1 || die "Removing doc/Makefile failed"
	dodoc AUTHORS NEWS README TODO || die "Installation of documentation failed"
}
