EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1

DESCRIPTION="Programmer for FPGA boards using the TinyFPGA USB Bootloader"
HOMEPAGE="https://github.com/tinyfpga/TinyFPGA-Bootloader/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/tinyprog-1.0.24.dev20.tar.gz -> ${P}.tar.gz"
PATCHES="$FILESDIR/$P-nongit.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pyserial-3
	 <dev-python/pyserial-4
	 >=dev-python/jsonmerge-1.4
	 <dev-python/jsonmerge-2
	 >=dev-python/intelhex-2.2.1
	 <dev-python/intelhex-3
	 >=dev-python/tqdm-4.19.5
	 <dev-python/tqdm-5
	 dev-python/six
	 dev-python/packaging
	 dev-python/pyusb"
DEPEND=""

src_unpack() {
  cd $WORKDIR
  unpack $A
  mv $WORKDIR/tinyprog-1.0.24.dev20 $WORKDIR/$P
}
