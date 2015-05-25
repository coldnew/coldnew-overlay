# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/Aseman-Land/libqtelegram-aseman-edition.git"
EGIT_BRANCH="master"

# v3.3 tag
EGIT_COMMIT="2f47ec91baedd21d494703d8ab18dd72e2af56ae"

inherit git-2 qmake-utils

IUSE=""
DESCRIPTION="A Qt library to access telegram"
HOMEPAGE="https://github.com/Aseman-Land/libqtelegram-aseman-edition"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtnetwork:5
	dev-qt/qtmultimedia:5
	media-libs/thumbnailer
	media-libs/libmediainfo
	dev-libs/openssl
  "

RDEPEND="${DEPEND}"

src_configure() {
  # remove the fucking debian/ubuntu only hardcode path
  sed -i 's#target.path = $$PREFIX/lib/$$LIB_PATH#target.path = $$PREFIX/lib#' libqtelegram-ae.pro

  eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}