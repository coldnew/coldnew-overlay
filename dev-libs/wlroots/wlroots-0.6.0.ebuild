EAPI=6

inherit meson

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/swaywm/wlroots.git"
	inherit git-2
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/swaywm/wlroots/archive/${P}.tar.gz"
	S="${WORKDIR}/${PN}-${P}"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="ISC"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="dev-libs/wayland
	dev-libs/wayland-protocols
	media-libs/mesa
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
	$RDEPEND"

S=${WORKDIR}/${P}

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git-2_src_unpack
	else
		default_src_unpack
	fi
}

src_configure() {
        meson_src_configure
}

src_install() {
        meson_src_install
}
