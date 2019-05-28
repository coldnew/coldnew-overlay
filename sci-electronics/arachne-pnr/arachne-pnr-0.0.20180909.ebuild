EAPI=6

GIT_COMMIT=840bdfdeb38809f9f6af4d89dd7b22959b176fdd
S=$WORKDIR/$PN-$GIT_COMMIT

DESCRIPTION="place-and-route tool for FPGAs"
HOMEPAGE="https://github.com/YosysHQ/arachne-pnr"
SRC_URI="https://github.com/YosysHQ/$PN/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz"
LICENSE=MIT
SLOT=0
KEYWORDS=~amd64

DEPEND="sci-electronics/icestorm"

src_compile() {
	emake DESTDIR="$D" PREFIX=/usr
}

src_install() {
	emake DESTDIR="$D" PREFIX=/usr install	
}
