EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )

inherit distutils-r1

DESCRIPTION=" Python bindings for the remote Jenkins API "
HOMEPAGE="http://git.openstack.org/cgit/openstack/python-jenkins https://pypi.org/project/python-jenkins"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""