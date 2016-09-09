# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils linux-info versionator

SLOT="0"
PV_STRING="$(get_version_component_range 3-6)"
MY_PV="$(get_version_component_range 1-2)"
MY_PN="idea"

# distinguish settings for official stable releases and EAP-version releases
if [[ "$(get_version_component_range 7)x" = "prex" ]]
then
	# upstream EAP
	KEYWORDS=""
	SRC_URI="https://download.jetbrains.com/idea/${MY_PN}IC-${PV_STRING}.tar.gz"
else
	# upstream stable
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://download.jetbrains.com/idea/${MY_PN}IC-${PV_STRING}.tar.gz -> ${MY_PN}IC-${PV_STRING}.tar.gz"
fi

DESCRIPTION="A complete toolset for web, mobile and enterprise development"
HOMEPAGE="https://www.jetbrains.com/idea"

LICENSE="IDEA"
IUSE=""

#https://intellij-support.jetbrains.com/hc/en-us/articles/206544879-Selecting-the-JDK-version-the-IDE-will-run-under
DEPEND="!dev-util/${PN}:14
	!dev-util/${PN}:15"
RDEPEND="${DEPEND}
	>=virtual/jdk-1.8:*"
S="${WORKDIR}/${MY_PN}-IC-${PV_STRING}"

QA_PREBUILT="opt/${PN}-${MY_PV}/*"

CONFIG_CHECK="~INOTIFY_USER"

src_prepare() {
	if ! use amd64; then
		rm -rf lib/libpty/linux/x86_64
		rm -f bin/fsnotifier64 bin/libbreakgen64.so bin/idea64.vmoptions
	fi
	if ! use x86; then
		rm -rf lib/libpty/linux/x86
		rm -f bin/fsnotifier bin/libbreakgen.so bin/idea.vmoptions
	fi
	rm -f bin/fsnotifier-arm
	rm -rf lib/libpty/{win,macosx}
	rm Install-Linux-tar.txt
}

src_install() {
	local dir="/opt/${PN}-${MY_PV}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${MY_PN}.sh" "${dir}/bin/inspect.sh"

	if use amd64; then
		fperms 755 "${dir}/bin/fsnotifier64"
	fi
	if use x86; then
		fperms 755 "${dir}/bin/fsnotifier"
	fi

	newicon "bin/idea.png" "${PN}.png"
	make_wrapper "${PN}" "${dir}/bin/${MY_PN}.sh"

	#https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${D}/etc/sysctl.d/"
	echo "fs.inotify.max_user_watches = 524288" > "${D}/etc/sysctl.d/30-${PN}-inotify-watches.conf"

	make_desktop_entry ${PN} "IntelliJ IDEA (Community Edition)" "${PN}" "Development;IDE"
}

pkg_postinst() {
	/sbin/sysctl fs.inotify.max_user_watches=524288 >/dev/null
}
