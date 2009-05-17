# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

MY_P="${P/_}"

DESCRIPTION="clustered file-system, capable of scaling to several peta-bytes"
HOMEPAGE="http://www.gluster.org/docs/index.php/GlusterFS"
SRC_URI="http://ftp.zresearch.com/pub/gluster/${PN}/$(get_version_component_range 1-2)/${PV/_*}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="" # ~amd64 ~x86
IUSE=""

DEPEND=">=sys-fs/fuse-2.6.0"
RDEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--localstatedir=/var \
		--docdir=/usr/share/doc/${PF} \
		--disable-ibverbs \
		--enable-fuse-client \
		--disable-bdb \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	newinitd "${FILESDIR}"/glusterfsd.initd glusterfsd || die "newinitd failed"
	newconfd "${FILESDIR}"/glusterfsd.confd glusterfsd || die "newconfd failed"

	keepdir /var/log/glusterfs
	dodoc README
}
