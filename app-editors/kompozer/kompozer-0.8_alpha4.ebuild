inherit eutils mozconfig flag-o-matic multilib

DESCRIPTION="A web authoring system combining web file management and WYSIWYG editing"
HOMEPAGE="http://kompozer.net/"

MY_P=${P/_alpha/a}

SRC_URI="http://downloads.sourceforge.net/kompozer/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 amd64"
IUSE=""
DEPEND="x11-proto/printproto
        sys-apps/gawk
        dev-lang/perl
        >=media-libs/freetype-2.1.9-r1"

S=${WORKDIR}/mozilla

pkg_setup() {
	if ! built_with_use --missing true x11-libs/pango X; then
		eerror "Pango is not built with X useflag."
		eerror "Please add 'X' to your USE flags and re-emerge pango."
		die "Pango needs X"
	fi
}

src_unpack() {
        unpack ${A}
	cd ${S}
	cp ${FILESDIR}/mozconfig-${PVR} ./.mozconfig
}

src_compile() {
	make -f client.mk build_all || die "Make failed"
}

src_install() {
	#Dirty Bugfix by unregistr3d (ignore nsModules.o):
	cd xpfe/components/
	cp Makefile.in Makefile.in_backup
	cat Makefile.in_backup | grep -v build2 > Makefile.in
	cd ../..

	make -f client.mk DESTDIR=${D} install || die

	#menu entry for gnome/kde
	insinto /usr/share/applications
	sed -e "s:/usr/lib/kompozer:/usr/$(get_libdir)/kompozer:" \
               ${FILESDIR}/kompozer.desktop > ${T}/kompozer.desktop
	doins ${T}/kompozer.desktop

	# Remove useless file to avoid package-collision:
	rm ${D}/usr/share/aclocal/nspr.m4
}

pkg_postinst() {
	elog "This package has a very dirty bugfix!!! If you want to fill"
	elog "a Bugreport to the mainstream developers, at least be sure"
	elog "to refer to http://bugs.gentoo.org/show_bug.cgi?id=146761#c39 "
	elog "Thanks"
}
