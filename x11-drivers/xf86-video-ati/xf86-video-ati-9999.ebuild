# Copyright 1999-2007 Gentoo Foundation                                                   
# Distributed under the terms of the GNU General Public License v2                         
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.6.192.ebuild,v 1.1 2007/05/21 05:25:33 dberkholz Exp $                                                 

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="ATI video driver"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
SRC_URI=""
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.2"
DEPEND="${RDEPEND}
        >=x11-misc/util-macros-1.1.3
        x11-proto/fontsproto
        x11-proto/randrproto
        x11-proto/videoproto
        x11-proto/xextproto
        x11-proto/xineramaproto
        x11-proto/xf86miscproto
        x11-proto/xproto
        dri? ( x11-proto/glproto
                        x11-proto/xf86driproto
                        >=x11-libs/libdrm-2 )"

CONFIGURE_OPTIONS="$(use_enable dri)" 
