# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils git-2

DESCRIPTION="Help track git Work In Progress branches"
GITHUB_USER="bartman"
HOMEPAGE="https://github.com/${GITHUB_USER}/${PN}"

GIT_ECLASS="git-2"
EGIT_REPO_URI="https://github.com/${GITHUB_USER}/git-wip.git"
#EGIT_COMMIT="55ab6c4ec"
S="${WORKDIR}"

LICENSE="AS-IS"
SLOT="0"
KEYWORDS="~amd64 ~x86 arm ~arm"
IUSE=""

RDEPEND=""

src_prepare() { :; }

src_compile() { :; }

src_install() {
	exeinto /usr/bin
	doexe git-wip || die "doexe failed"

	dodoc README.markdown
}
