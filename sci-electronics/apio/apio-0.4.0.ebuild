EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="Open source ecosystem for open FPGA boards"
HOMEPAGE="http://apiodoc.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/click-5
	 <dev-python/click-7
	 >=dev-python/semantic_version-2.5
	 <dev-python/semantic_version-3
	 >=dev-python/requests-2.4
	 <dev-python/requests-3
	 >=dev-python/pyjwt-1.5.3
	 <dev-python/pyjwt-2
	 dev-python/colorama
	 >=dev-python/pyserial-3
	 <dev-python/pyserial-4"
DEPEND=""
