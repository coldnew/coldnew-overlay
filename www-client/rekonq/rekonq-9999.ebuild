# ==========================================================================
# This ebuild come from kde-testing repository. Zugaina.org only host a copy.
# For more info go to http://gentoo.zugaina.org/
# ************************ General Portage Overlay ************************
# ==========================================================================
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WEBKIT_REQUIRED="always"
inherit kde4-base git

DESCRIPTION="Konqueror replacement using webkit as backend."
HOMEPAGE="http://rekonq.adjam.org/"
EGIT_REPO_URI="git://gitorious.org/rekonq/mainline.git"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="debug"
