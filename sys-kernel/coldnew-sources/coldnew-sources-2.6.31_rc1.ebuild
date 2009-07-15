# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 2009/07/13 23:01:39 coldnew Exp $

ETYPE="sources"
inherit kernel-2
detect_version
detect_arch

KEYWORDS="~amd64 ~x86"
IUSE=""
HOMEPAGE=""

DESCRIPTION="Full sources including the Gentoo patchset and some other collected
on Internet by coldnew for personaly use"

SRC_URI="${KERNEL_URI}"

UNIPATCH_LIST=" ${FILESDIR}/2.6.30-coldnew.tar 
				${FILESDIR}/${PV}/0010_reiser4-for-2.6.30.patch.lzma
				${FILESDIR}/${PV}/0040_aufs2-2.6.30-das.patch.lzma
				${FILESDIR}/${PV}/0050_tuxonice-for-2.6.30-20090620-v1.patch.lzma
				${FILESDIR}/${PV}/0060_march-native.patch.lzma
				${FILESDIR}/${PV}/1000_linux-2.6.30.1.patch.lzma
				${FILESDIR}/${PV}/4100_dm-bbr.patch.lzma
				${FILESDIR}/${PV}/4201_fbcondecor-0.9.6.patch.lzma
				${FILESDIR}/${PV}/4400_alpha-sysctl-uac.patch.lzma
				${FILESDIR}/${PV}/9990_coldnew-tag.patch.lzma
				${FILESDIR}/${PV}/utf8-kernel-2.6-core-1.patch.lzma
				${FILESDIR}/${PV}/utf8-kernel-2.6-fonts2.patch.lzma
				${FILESDIR}/${PV}/utf8-kernel-2.6-fbcondecor-1.patch.lzma
				"

UNIPATCH_STRICTORDER="yes"
K_PREPATCHED="yes"

