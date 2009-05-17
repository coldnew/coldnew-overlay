# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

DESCRIPTION="clustered file-system, capable of scaling to several peta-bytes"
HOMEPAGE="http://www.gluster.org/docs/index.php/GlusterFS"
SRC_URI="http://ftp.zresearch.com/pub/gluster/${PN}/$(get_version_component_range 1-2)/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-fs/fuse-2.6.0"
RDEPEND="${RDEPEND}"

src_compile() {
	econf \
		--localstatedir=/var \
		--disable-ibverbs \
		--enable-fuse-client \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake \
		install \
		DESTDIR="${D}" \
		docdir="/usr/share/doc/${PF}" \
		|| die "emake install failed"

	newinitd "${FILESDIR}"/glusterfsd.initd glusterfsd || die "newinitd failed"
	newconfd "${FILESDIR}"/glusterfsd.confd glusterfsd || die "newconfd failed"

	keepdir /var/log/glusterfs
	dodoc README
}
