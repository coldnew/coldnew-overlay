# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/enterminus/enterminus-9999.ebuild,v 1.1 2005/09/07 03:52:46 vapier Exp $

ESVN_SUB_PROJECT="PROTO"
inherit enlightenment

DESCRIPTION="The enlightened way to exchange stuffs"

IUSE="etk ewl"

DEPEND="dev-libs/eina
	x11-libs/ecore
	x11-libs/evas
	media-libs/edje
	dev-libs/libxml2
	etk? ( x11-libs/etk )
	ewl? ( x11-libs/ewl )"
