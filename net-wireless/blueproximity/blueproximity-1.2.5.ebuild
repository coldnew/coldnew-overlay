# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DESCRIPTION="Proximity detector for your mobile phone via bluetooth"
HOMEPAGE="http://blueproximity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

LANGS=" de en es fa hu it ru sv th"
IUSE="${IUSE} ${LANGS// / linguas_}"

RDEPEND="dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/pybluez[${PYTHON_USEDEP}]
	>=dev-python/pygtk-2.0[${PYTHON_USEDEP}]"
DEPEND=""

S="${WORKDIR}/${P}.orig"

src_install() {
	sed -i -r "s:\`dirname \\\$PRG\`:/usr/lib/${PN}:" start_proximity.sh
	sed -i "s#python #${PYTHON} #" start_proximity.sh
	newbin start_proximity.sh blueproximity
	insinto "/usr/lib/${PN}"
	doins blueproximity* proximity*
	dodoc README ChangeLog
	dodoc doc/*
	doman doc/blueproximity.1
	domenu addons/blueproximity.desktop
	doicon addons/blueproximity.xpm
	strip-linguas ${LANGS}
	for l in ${LINGUAS};
	do
		dodir "/usr/lib/${PN}/LANG/${l}"
		cp -r "${S}/LANG/${l}" "${D}/usr/lib/${PN}/LANG"
	done
}