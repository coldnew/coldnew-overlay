# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5} )
inherit eutils python-r1 git-2 multilib

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
EGIT_REPO_URI="https://github.com/libimobiledevice/libimobiledevice.git"

# While COPYING* doesn't mention 'or any later version', all the headers do, hence use +
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/6" # based on SONAME of libimobiledevice.so
KEYWORDS=""
IUSE="gnutls python static-libs"

RDEPEND=">=app-pda/libplist-1.11:=
	>=app-pda/libusbmuxd-1.1.0:=
	gnutls? (
		dev-libs/libgcrypt:0
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
		)
	!gnutls? ( dev-libs/openssl:0 )
	python? (
		${PYTHON_DEPS}
		app-pda/libplist[python(-),${PYTHON_USEDEP}]
		)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	python? ( >=dev-python/cython-0.17[${PYTHON_USEDEP}] )"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( AUTHORS NEWS README )

src_configure() {

	local ECONF_SOURCE=${S}

	local myeconfargs=( $(use_enable static-libs static) )
	use gnutls && myeconfargs+=( --disable-openssl )

	do_configure() {
		local PREFIX="${EPREFIX}"/usr
		local LIBDIR="${PREFIX}"/$(get_libdir)
		./autogen.sh --prefix="${PREFIX}" --libdir="${LIBDIR}" "${myeconfargs[@]}" "${@}"
	}

	do_configure_python() {
		# Bug 567916
		PYTHON_LDFLAGS="$(python_get_LIBS)" do_configure "$@"
	}

	do_configure --without-cython
	use python && python_foreach_impl do_configure_python
}

src_compile() {
	python_compile() {
		emake -C "${S}"/cython -j1 \
			VPATH="${S}/cython:${native_builddir}/cython" \
			imobiledevice_la_LIBADD="${native_builddir}/src/libimobiledevice.la"
	}

	local native_builddir=${S}
	emake -j1
	use python && python_foreach_impl python_compile
}

src_install() {
	python_install() {
		emake -C "${S}/cython" -j1 \
			VPATH="${S}/cython:${native_builddir}/cython" \
			DESTDIR="${D}" install
	}

	local native_builddir=${S}
	emake -j1 DESTDIR="${D}" install
	use python && python_foreach_impl python_install

	# dodoc docs/html/*
	if use python; then
		insinto /usr/include/${PN}/cython
		doins cython/imobiledevice.pxd
	fi
	prune_libtool_files --all
}
