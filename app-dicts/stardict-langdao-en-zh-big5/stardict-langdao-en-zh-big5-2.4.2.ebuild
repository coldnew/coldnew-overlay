# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Collection of dicts for stardict."
HOMEPAGE="http://gnome.msiu.ru/stardict.php"
SRC_URI="http://yeelou.com/huzheng/stardict-dic/zh_TW/stardict-langdao-ec-big5-2.4.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/stardict"

DEPEND=""

src_install() {
	dodir /usr/share/stardict/dic
	tar xvf  "${DISTDIR}/stardict-langdao-ec-big5-2.4.2.tar.bz2" "${D}/usr/share/stardict/dic/"
}
