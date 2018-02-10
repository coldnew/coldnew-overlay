# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="github.com/exercism/cli"

KEYWORDS="~x86 ~amd64"
EGIT_COMMIT=v${PV}
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"

IUSE="
	xclojure
	xcpp
	xerlang
"

PDEPEND="
	xclojure? ( dev-java/leiningen-bin )
	xcpp? ( sys-devel/gcc dev-util/cmake >=dev-libs/boost-1.59.0 )
	xerlang? ( dev-lang/erlang dev-util/rebar3 )
"

DESCRIPTION="Command-Line-Tool for the exercism.io website."
HOMEPAGE="http://exercism.io/"

inherit golang-vcs-snapshot
inherit golang-build

src_compile() {
	ego_pn_check
	einfo "Building exercism"
	set -- env GOPATH="${S}:$(get_golibdir_gopath)" \
		go build -work -x ${EGO_BUILD_FLAGS} "${EGO_PN}/exercism"
	echo "$@"
	"$@" || die
}

src_install() {
	ego_pn_check
	einfo "Creating binary file"
	set -- env GOPATH="${S}:$(get_golibdir_gopath)" \
		go install -work -x "${EGO_PN}/exercism"
	echo "$@"
	"$@" || die
	newbin "${S}/bin/exercism" exercism
}
