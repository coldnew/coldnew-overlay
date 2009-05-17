# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-laptop/lapsus-9999.ebuild, v1.2 j0inty/kshots $

inherit eutils linux-info qt3 flag-o-matic 

DESCRIPTION="${PN} - Linux on laptops"
HOMEPAGE="http://lapsus.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="arts debug"

DEPEND=""
RDEPEND=">=x11-libs/qt-3.3:3
   >=sys-apps/dbus-0.90
   kde-base/kdelibs
   arts? ( kde-base/arts )"

CONFIG_CHECK="BACKLIGHT_CLASS_DEVICE"
ERROR_BACKLIGHT_CLASS_DEVICE="Please add the Lowlevel Backlight controls to your kernel
	--> Device Drivers
		--> Graphic support
			--> Backlight & LCD device support
				--> Lowlevel Backlight controls"

CONFIG_CHECK="LEDS_CLASS"
ERROR_LEDS_CLASS="Please add the Led Class support into your kernel
	--> Device Drivers
		--> Led support
			--> <M> Led Class support"

CONFIG_CHECK="ASUS_LAPTOP"
ERROR_ASUS_LAPTOP="You must add the Asus Laptop Extras module to your kernel
	--> Device Drivers
		--> Misc Devices
			-->  <M>   Asus Laptop Extras (EXPERIMENTAL)
If you don't find the entry for the module you should check is the follow module NOT selected
	--> Power management options
		--> ACPI (Advanced Configuration and Power Interface) Support
			< > ASUS/Medion Laptop Extras"

src_compile() {
   # This LDFlag doesn't work for the internal qt3backport libary so we took this out
   filter-ldflags "-Wl,--as-needed"
   econf $(use_with arts) \
         $(use_enable debug) || die "econf failed"
   emake || die "emake failed"
}

src_install() {
   emake DESTDIR="${D}" install || die "emake install failed"
   insinto /etc/dbus-1/system.d/
   doins ${PN}.conf
   newconfd ${FILESDIR}/${PN}d.confd ${PN}d
   newinitd ${FILESDIR}/${PN}d.initd ${PN}d
   dodoc AUTHORS README ChangeLog INSTALL
}

pkg_postinst() {
   enewgroup ${PN}
   echo
   elog "If you have an ASUS or IBM laptop, be sure to compile kernel with support for Asus Laptop Extras or ThinkPad ACPI Laptop Extras"
   elog ""
   elog "dbus has to be restarted."
   elog "You should restart it with: /etc/init.d/dbus restart"
   elog ""
   elog "${PN}d has to be started."
   elog "You should start it with: /etc/init.d/${PN}d start"
   elog ""
   elog "You must be in the ${PN} group to use ${PN} or you change the group over /etc/conf.d/${PN}d"
   elog "LAPSUSD_GROUP=\"<othergroupname>\""
   elog ""
   elog "Make an \"usermod -a -G ${PN} <username>\" if you want to add any user to the group"
   elog "" 
   elog "You might have to restart KDE to use the ${PN} applet"
}
