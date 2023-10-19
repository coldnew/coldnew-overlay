# Ghidra ebuild (binary version)
# Maintainer: Xoores <gentoo@xoores.cz>
EAPI=8

# For some reason NSA likes to "stamp" releases with build date. That's
# nice, but it is a PITA because I have to change this for every release :-(
GHIDRA_DATESTAMP="20230928"

# Install Ghidra to /opt and use separate directory for each version. That
# will enable us to keep multiple versions installed at the same time.
GHIDRA_DESTDIR="/opt/ghidra-${PV}"


DESCRIPTION="A software reverse engineering (SRE) suite of tools developed by NSA"
HOMEPAGE="https://ghidra-sre.org/"
SRC_URI="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${PV}_build/ghidra_${PV}_PUBLIC_${GHIDRA_DATESTAMP}.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

# Do not try to get this from mirrors...
RESTRICT="mirror"

# Ghidra needs OpenJDK 11 64bit
DEPEND="
	dev-java/openjdk-bin:11
	dev-java/openjdk-jre-bin:11
	"
	
RDEPEND="${DEPEND}"

src_unpack()
{
	default
	
	# Need to "fix" the default unzip directory of Ghidra...
	mv "ghidra_${PV}_PUBLIC" "${P}"
}

src_install() {
	insinto "${GHIDRA_DESTDIR}"
	
	# Copy just about everything - we don't really care for .bat though. I
	# know that there are many more in support/ directory, but hey...
	doins -r Extensions GPL Ghidra docs licenses server support
	doins LICENSE ghidraRun
	
	# Need to set +x on some files...
	fperms 0755 \
		"${GHIDRA_DESTDIR}/ghidraRun" \
		"${GHIDRA_DESTDIR}/support/analyzeHeadless" \
		"${GHIDRA_DESTDIR}/support/launch.sh" \
		"${GHIDRA_DESTDIR}/support/pythonRun" \
		"${GHIDRA_DESTDIR}/support/sleigh" 
	
	# Also it would be nice to run ghidra like a sane person :-)
	dosym "${GHIDRA_DESTDIR}/ghidraRun" /usr/bin/ghidra
	
}

# Let's be extra nice and cover some common pitfalls that I ran into
pkg_postinst() {
	ewarn "For ease of use I created symlink for Ghidra:"
	ewarn "  ${GHIDRA_DESTDIR}/ghidraRun -> /usr/bin/ghidra"
	ewarn "To launch Ghidra, you can just launch /usr/bin/ghidra or ghidra"
	ewarn ""
	ewarn "OpenJDK 11 (for some reason) does not yet have gentoo-vm USE flag available"
	ewarn "so you might want to expliciely tell Ghidra location of OpenJDK. You"
	ewarn "might do that by setting an alias by adding this to your .bashrc:"
	ewarn "  alias ghidra='JAVA_HOME_OVERRIDE=\"/opt/openjdk-jre-bin-11/\" ghidra'"
	ewarn ""
	ewarn "For HiDPI monitors you might have to edit config file located at"
	ewarn "/opt/ghidra-${PV}/support/launch.properties and change"
	ewarn "property sun.java2d.uiScale from 1 to the same value as GDK_SCALE"
	ewarn "which is usualy 2 or something similar."
	ewarn "You can find out current value of GDK_SCALE by running following"
	ewarn "command in any shell:"
	ewarn "  echo \$GDK_SCALE"
	ewarn ""
}
