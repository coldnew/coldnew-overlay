# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Gentoo Development Guide http://devmanual.gentoo.org/ebuild-writing/index.html
# Ebuild: created by Turketi Sergei - newlisper@gmail.com
#
# EXAMPLE:
#
# If you want the possibility of libffi (USE="libffi"), then:
#
#   user$ find /usr/ -name ffi.h
#     /usr/lib64/libffi-3.0.10/include/ffi.h
#
# If you have a flag USE = "x86" then:
#
#   root# mkdir /usr/include/i386-linux-gnu/
#   root# ln -s /usr/lib/libffi-3.0.10/include/ffi.h /usr/include/i386-linux-gnu/
#
# If you have a flag USE = "amd64" then:
#
#   root# mkdir /usr/include/x86_64-linux-gnu/
#   root# ln -s /usr/lib/libffi-3.0.10/include/ffi.h /usr/include/x86_64-linux-gnu/
#
# To all:
#   user$ find /usr/ -name ffitarget.h
#     /usr/lib64/libffi-3.0.10/include/ffitarget.h
#   root# ln -s /usr/lib64/libffi-3.0.10/include/ffitarget.h /usr/include/
#

EAPI="5"
DESCRIPTION="newLISP - a new generation of Lisp!"
HOMEPAGE="http://www.newlisp.org/"
SRC_URI="http://www.newlisp.org/downloads/${P}.tgz"
LICENSE="GPL-3"
IUSE="libffi unicode"
SLOT="0"
KEYWORDS="x86 amd64 ~arm"
RDEPEND="sys-libs/readline
  	   app-admin/sudo
  	   libffi? ( dev-libs/libffi )"
DEPEND="${RDEPEND}"

src_configure ()
{
	return
}

src_compile ()
{
	cd "{S}"

	# compile for x86
	if [ "${ARCH}" == "x86" ]; then
	  if use libffi ; then
		  make -f makefile_linux_utf8_ffi
	  else
		  make -f makefile_linux_utf8
	  fi
	fi

	# compile for amd64
	if [ "${ARCH}" == "amd64" ]; then
	  if use libffi ; then
		  make -f makefile_linuxLP64_utf8_ffi
	  else
		  make -f makefile_linuxLP64_utf8
	  fi
	fi

	# compile for arm
	if [ "${ARCH}" == "arm" ]; then
 	  # remove -m32
	  sed -i makefile_linux_utf8_ffi 's/-m32//g'
  	  sed -i makefile_linux_utf8 's/-m32//g'

	  if use libffi ; then
		  make -f makefile_linux_utf8_ffi
	  else
		  make -f makefile_linux_utf8
	  fi
	fi
}

src_install()
{
	  sudo make install
}
