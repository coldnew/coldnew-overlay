# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="A new Lisp dialect"
HOMEPAGE="http://www.newlisp.org"
SRC_URI="mirror://sourceforge/newlisp/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
# please keep sorted
KEYWORDS="~amd64 ~x86"
IUSE="tk"

DEPEND="sys-libs/readline
		tk? ( dev-lang/tk )"

src_prepare() {
	cp Makefile Makefile.old

	# remove bad stuff
	sed -e "s,strip.*,," -e "s,-O.,," -e "s,-g,," -e "s,-m32,," -i makefile_*
	# respect CFLAGS and add -fPIC which is needed at least for amd64
	sed "s,CFLAGS =\(.*\),CFLAGS =\1 -fPIC ${CFLAGS}," -i makefile_*

	# do not assume target directories exist
	sed "s#^install:#install:\n\tmkdir -p \$(DESTDIR)\$(datadir)/{doc/${P}/html/guiserver,${PN}/{examples,modules}} \$(DESTDIR)\$(bindir) \$(DESTDIR)\$(mandir)/man1/#" -i Makefile
	# fix some paths
	sed '/-install .*html$/s:/doc/newlisp/:/doc/newlisp/html/:g' -i Makefile
#	sed '/-install .* modules/s:(datadir)/newlisp:(datadir)/newlisp/modules:g' -i Makefile
	sed '/-install .* examples/s:(datadir)/newlisp:(datadir)/newlisp/examples:g' -i Makefile
	sed "s:/doc/newlisp:/doc/${P}:g" -i Makefile

	# remove duplicate licenses
	sed "/.*COPYING.*/s" -i Makefile

	# add DESTDIR support
	sed "s:\(install.* \$(\)\(.*\):\1DESTDIR)\$(\2:" -i Makefile
	sed "/\t-rm.*/d" -i Makefile
	sed "s:-\(ln -s.*ION) \):\1\$(DESTDIR):" -i Makefile

	# fail on failing install
	sed "s#-install#install#" -i Makefile

	diff -u Makefile.old Makefile
}

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
}
