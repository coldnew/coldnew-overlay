# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="doc examples source"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils check-reqs java-pkg-2 java-ant-2 versionator

MY_P="${P}.final-sources"
BIN_P="${P}.final"

DESCRIPTION="The Scala Programming Language"
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="!binary? ( http://www.scala-lang.org/downloads/distrib/files/${MY_P}.tgz )
		binary? ( http://www.scala-lang.org/downloads/distrib/files/${BIN_P}.tgz )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="binary emacs"
# one fails with 1.7, two with 1.4 (blackdown)
RESTRICT="test"

DEPEND=">=virtual/jdk-1.6
	!binary? (
		dev-java/ant-contrib
	)"
RDEPEND=">=virtual/jre-1.6
	!dev-java/scala-bin"

PDEPEND="emacs? ( app-emacs/scala-mode )"

if ! use binary; then
	S="${WORKDIR}/${MY_P}"
else
	S="${WORKDIR}/${BIN_P}"
fi

pkg_setup() {
	java-pkg-2_pkg_setup

	ewarn "This ebuild has been ported from the 2.7.7 version and contains a lot
	of inconsistencies. Use it with caution !"
	ewarn "Note that more than 2GB of ram were used to build the 2.8.0 version"

	ewarn "Feel free to post an updated ebuild on bugzilla (see bug #328291"

	if ! use binary; then
		debug-print "Checking for sufficient physical RAM"

		ewarn "This package can fail to build with memory allocation errors in some cases."
		ewarn "If you are unable to build from sources, please try USE=binary"
		ewarn "for this package. See bug #181390 for more information."
		ebeep 3
		epause 5

		if use amd64; then
			CHECKREQS_MEMORY="1024"
		else
			CHECKREQS_MEMORY="512"
		fi

		check_reqs
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use binary; then

		cd lib || die
		java-pkg_jar-from --build-only ant-contrib
	fi
}

src_compile() {
	if ! use binary; then
		# reported in bugzilla that multiple launches use less resources
		# https://bugs.gentoo.org/show_bug.cgi?id=282023
		eant all.clean
		eant build-opt
		eant dist.done
	else
		einfo "Skipping compilation, USE=binary is set."
	fi
}

src_test() {
	eant test.suite || die "Some tests aren't passed"
}

scala_launcher() {
	local SCALADIR="/usr/share/${PN}"
	local bcp="${SCALADIR}/lib/scala-library.jar"
	java-pkg_dolauncher "${1}" --main "${2}" \
		--java_args "-Xmx256M -Xms32M -Dscala.home=${SCALADIR} -Denv.emacs=${EMACS}"
}

src_install() {
	if ! use binary; then
		cd dists/latest || die
	fi

	local SCALADIR="/usr/share/${PN}/"

	#sources are .scala so no use for java-pkg_dosrc
	if use source; then
		dodir "${SCALADIR}/src"
		insinto "${SCALADIR}/src"
		doins src/*-src.jar
	fi

	java-pkg_dojar lib/*.jar

	doman man/man1/*.1 || die
	
	#docs and examples are not contained in the binary tgz anymore
	if ! use binary; then
		local docdir="doc/${PN}-devel-docs"
		dodoc doc/README ../../docs/TODO || die
		if use doc; then
			java-pkg_dojavadoc "${docdir}/api"
			dohtml -r "${docdir}/tools" || die
		fi

		use examples && java-pkg_doexamples "${docdir}/examples"
	fi


	scala_launcher fsc scala.tools.nsc.CompileClient
	scala_launcher scala scala.tools.nsc.MainGenericRunner
	scala_launcher scalac scala.tools.nsc.Main
	scala_launcher scaladoc scala.tools.nsc.ScalaDoc
	scala_launcher scalap scala.tools.scalap.Main
}
