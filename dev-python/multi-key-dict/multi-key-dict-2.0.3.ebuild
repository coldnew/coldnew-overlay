EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )

inherit distutils-r1

DESCRIPTION="Multi key dictionary implementation"
HOMEPAGE="https://github.com/formiaczek/multi_key_dict https://pypi.python.org/pypi/multi_key_dict"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/multi_key_dict-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/multi_key_dict-${PV}"