EAPI=5
inherit eutils
DESCRIPTION="a lightweight hotkey daemon"
HOMEPAGE="https://github.com/wertarbyte/triggerhappy"
SRC_URI="https://github.com/wertarbyte/triggerhappy/archive/release/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

src_unpack()
{
  unpack ${P}.tar.gz
  mv ${PN}-release-${PV} ${P}
}

