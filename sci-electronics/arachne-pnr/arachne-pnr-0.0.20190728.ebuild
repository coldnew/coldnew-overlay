EAPI=6

GIT_COMMIT=c40fb2289952f4f120cc10a5a4c82a6fb88442dc
S=$WORKDIR/$PN-$GIT_COMMIT

DESCRIPTION="place-and-route tool for FPGAs"
HOMEPAGE="https://github.com/YosysHQ/arachne-pnr"
SRC_URI="https://github.com/YosysHQ/$PN/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz"
LICENSE=MIT
SLOT=0
KEYWORDS=amd64

DEPEND="sci-electronics/icestorm"

src_compile() {
	emake DESTDIR="$D" PREFIX=/usr
}

src_install() {
	emake DESTDIR="$D" PREFIX=/usr install	
}
