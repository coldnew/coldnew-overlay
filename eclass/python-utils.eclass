# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: Tiziano Müller <dev-zero@gentoo.org>
# Purpose: Various helper functions to handle python packages on Gentoo
#

# TODO:
# 1. Write empty needed functions with a 'die "not implemented"'
# 2. Write the documentation for the given function
# 3. implement the tests according to what the functions should do
# 4. implement the functions
#
# - discuss: install .py[co] in src_install and remove .py if possible?
#            what about cleanup/optimize?
# - discuss: should all functions die on error?

# @FUNCTION: pyutils_get_available_versions
# @DESCRIPTION:
# Get versions of installed python interpreters
pyutils_get_available_python_versions() {
	die "not implemented"
}

# @FUNCTION: pyutils_get_python_version
# @DESCRIPTION:
# ...
pyutils_get_python_version() {
	die "not implemented"
}

# @FUNCTION: pyutils_get_site_dir
# @DESCRIPTION:
# Returns the site-packages dir of the current python version
pyutils_get_sitedir() {
	die "not implemented"
}

# @FUNCTION: pyutils_get_sitedirs
# @DESCRIPTION:
# Get a list of site-dirs for installed python interpreters
# (note: use this function instead of a handcrafted loop over the versions since
#  we might provide different python variations with the same version)
pyutils_get_sitedirs() {
	die "not implemented"
}

# @FUNCTION: pyutils_detect_ezsetup
# @DESCRIPTION:
# Check whether a package uses ez_setup.
# Precondition: setup.py must be present and readable (should it really fail???)
pyutils_detect_ezsetup() {
	if [ ! -f "setup.py" ] || [ ! -h "setup.py" ] ; then
		die "setup.py not found"
	fi

	if [ $(grep -e "ez_setup" "setup.py" &>/dev/null) ] ; then
		return 0
	fi
	return 1
}

# @FUNCTION: pyutils_disable_ezsetup
# @DESCRIPTION:
# Replace ez_setup.py (if needed) by a stub
pyutils_disable_ezsetup() {
	die "needs parameter handling for optional target dir"
	cd "${S}"
	if pyutils_detect_ezsetup ; then
		rm ez_setup.py || die "could not remove ez_setup.py"
		echo "def use_setuptools(*args, **kwargs): pass" > ez_setup.py
	fi
}

# @FUNCTION: pyutils_distutils_build
# @DESCRIPTION:
# ...
pyutils_distutils_build() {
	die "not implemented"
}

# @FUNCTION: pyutils_distutils_install
# @DESCRIPTION:
# ...
pyutils_distutils_install() {
	die "not implemented"
}

# @FUNCTION: pyutils_compile_path
# @DESCRIPTION:
# Compile all .py files in a _given_ path
pyutils_compile_path() {
	die "not implemented"
}

# @FUNCTION: pyutils_cleanup_path
# @DESCRIPTION:
# Cleanup stale .py[co] files in a _given_path
pyutils_cleanup_path() {
	die "not implemented"
}

# @FUNCTION: pyutils_compile_mod
# @DESCRIPTION:
# Compile a python module
# ... argument should be the name of a python module in site-packages
# ... ex. "google/protobuf" for a module in /usr/$(get_libdir)/python${PYVER}/site-packages/google/protobuf
# ... will optimize the module in the right python directory
# ... will optimize PYTHON_MODNAME if parameter not given and defined
# ... will optimize the whole site-packages else
pyutils_compile_mod() {
	die "not implemented"
}

# @FUNCTION: pyutils_cleanup_mod
# @DESCRIPTION:
# Cleanup stale .py[co] in a python module after uninstalling the package
# Will only remove a .py[co] if no corresponding .py is present, but in all
# site-package dirs to avoid stalled .py[co] files in older python's site-dir.
# Accepts more than one module. If no module is specified the PYTHON_MODNAME var
# will be checked. If that one is empty the complete site-package's dir will be
# cleaned.
pyutils_cleanup_mod() {
	local mods=""
	if [ $? -lt 0 ] ; then
		mods=$*
	elif [ -n "${PYTHON_MODNAME}" ] ; then
		mods="${PYTHON_MODNAME}"
	fi
	
	for mod in ${mods} ; do
		for sd in $(pyutils_get_sitedirs) ; do
			pyutils_path_cleanup "${sd}/${mod}"
		done
	done
}

#############
### TESTS ###
#############

test_detect_ezsetup() {
	S="$(test_vars testdata)/ezsetup_detection/without_ezsetup"
	 $(pyutils_detect_ezsetup) || die "test_detect_ezsetup.without_ezsetup failed"

	S="$(test_vars testdata)/ezsetup_detection/with_commented_ezsetup"
	$(pyutils_detect_ezsetup) && die "test_detect_ezsetup.with_commented_ezsetup failed"

	S="$(test_vars testdata)/ezsetup_detection/with_ezsetup"
	$(pyutils_detect_ezsetup) || die "test_detect_ezsetup.with_ezsetup failed"
}

test_distutils_build() {
	die "test not implemented"
}

test_distutils_install() {
	die "test not implemented"
}


test_vars() {
	case $1 in
		( "tmp" ) echo "/tmp" ;;
		( "testdata" ) echo "/tmp/python_eclass_testdata" ;;
	esac
}

test_setup() {
	if [ -e $(test_vars testdata) ] ; then
		die "test data already exists, please remove $(test_vars testdata) manually"
	fi

	cd $(test_vars tmp)
	svn export http://overlays.gentoo.org/svn/proj/python/eclass_testdata $(test_vars testdata) || die "svn export of the testdata failed"
}

test_teardown() {
	rm -rf /tmp/python_eclass_tests
}

test_runner() {
	test_setup

	test_distutils_build
	test_distutils_install

	test_teardown
}

