# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit meson

DESCRIPTION="IIO sensors to D-Bus proxy"
HOMEPAGE="https://gitlab.freedesktop.org/hadess/iio-sensor-proxy"
SRC_URI="https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib:*
	gnome-base/gnome-common
	virtual/libgudev
	virtual/udev"

DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	virtual/pkgconfig"
