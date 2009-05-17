# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Swarm is a platform for agent-based models."
HOMEPAGE="http://www.swarm.org"
SRC_URI="http://pj.freefaculty.org/Swarm/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="java hdf5"

DEPEND="dev-lang/tcl
		dev-lang/tk
		dev-tcltk/blt
		>=media-libs/libpng-1.2.5
		>=sys-libs/zlib-1.2.2
		x11-libs/libXpm
		virtual/emacs
		hdf5? ( >=sci-libs/hdf5-1.6.2 )
		java? ( >=virtual/jdk-1.4.2 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use --missing false gcc objc ; then
		eerror "Your GCC compiler has been built without Objective-C support."
		eerror "Please enable the 'objc' USE flag and re-emerge sys-devel/gcc."
		elog "You can enable this USE flag either globally in /etc/make.conf,"
		elog "or just for specific packages in /etc/portage/package.use."
		die "sys-devel/gcc missing objc support"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-amd64.patch
}

src_compile() {
	javaconf="--without-jdkdir"
	use java && javaconf="--with-jdkdir=`java-config -O`"
	hdf5conf="--without-hdf5dir"
	use hdf5 && hdf5conf="--with-hdf5dir"
	econf \
		--enable-shared \
		${javaconf} \
		${hdf5conf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README THANKS
}
