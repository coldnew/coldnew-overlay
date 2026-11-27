# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aes@0.9.3
	aho-corasick@1.1.5
	annotate-snippets@0.11.5
	anstyle@1.0.14
	anyhow@1.0.104
	arc-swap@1.9.3
	async-broadcast@0.7.2
	async-channel@2.5.0
	async-recursion@1.2.0
	async-trait@0.1.92
	autocfg@1.5.1
	base64@0.23.1
	bindgen@0.72.1
	bitflags@2.13.2
	bluer@0.17.4
	bumpalo@3.20.3
	bytes@1.12.1
	cairo-rs@0.22.9
	cairo-sys-rs@0.22.9
	cc@1.11.2
	cexpr@0.6.0
	cfg-expr@0.20.10
	cfg-if@1.0.5
	cfg_aliases@0.2.2
	cipher@0.5.2
	clang-sys@1.9.1
	concurrent-queue@2.5.0
	cookie-factory@0.3.3
	cpubits@0.1.1
	cpufeatures@0.3.1
	crossbeam-queue@0.3.14
	crossbeam-utils@0.8.23
	crypto-common@0.2.2
	dirs-sys@0.5.0
	dirs@7.0.0
	either@1.19.0
	endi@1.1.1
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	equivalent@1.0.2
	errno@0.3.14
	event-listener-strategy@0.5.4
	event-listener@5.4.2
	fastrand@2.5.0
	field-offset@0.3.6
	filedesc@0.6.3
	find-msvc-tools@0.1.15
	futures-channel@0.3.34
	futures-core@0.3.34
	futures-executor@0.3.34
	futures-io@0.3.34
	futures-lite@2.6.1
	futures-macro@0.3.34
	futures-sink@0.3.34
	futures-task@0.3.34
	futures-util@0.3.34
	futures@0.3.34
	gdk-pixbuf-sys@0.22.9
	gdk-pixbuf@0.22.0
	gdk4-sys@0.11.5
	gdk4@0.11.5
	getrandom@0.4.3
	gio-sys@0.22.9
	gio@0.22.10
	glib-build-tools@0.22.8
	glib-macros@0.22.9
	glib-sys@0.22.9
	glib@0.22.10
	glob@0.3.4
	gobject-sys@0.22.9
	graphene-rs@0.22.8
	graphene-sys@0.22.9
	gsk4-sys@0.11.5
	gsk4@0.11.5
	gtk4-macros@0.11.5
	gtk4-sys@0.11.5
	gtk4@0.11.5
	hashbrown@0.17.1
	heck@0.5.0
	hex@0.4.3
	hybrid-array@0.4.15
	indexmap@2.14.2
	inout@0.2.2
	itertools@0.13.0
	itoa@1.0.18
	js-sys@0.3.106
	ksni@0.3.7
	lazy_static@1.5.1
	libadwaita-sys@0.9.2
	libadwaita@0.9.2
	libc@0.2.191
	libloading@0.8.9
	libredox@0.1.25
	libspa-sys@0.10.1
	libspa@0.10.1
	linux-raw-sys@0.12.1
	log@0.4.34
	macaddr@1.0.1
	matchers@0.2.0
	memchr@2.8.3
	memoffset@0.9.1
	minimal-lexical@0.2.1
	mio@1.2.4
	nix@0.29.0
	nom@7.1.3
	nom@8.0.0
	nu-ansi-term@0.50.3
	num-derive@0.4.2
	num-traits@0.2.19
	once_cell@1.21.4
	option-ext@0.2.0
	ordered-stream@0.2.0
	pango-sys@0.22.9
	pango@0.22.9
	parking@2.2.1
	pastey@0.2.3
	pin-project-lite@0.2.17
	pipewire-sys@0.10.1
	pipewire@0.10.1
	pkg-config@0.3.34
	proc-macro-crate@3.5.0
	proc-macro2@1.0.107
	quote@1.0.47
	r-efi@6.0.0
	redox_users@0.5.3
	regex-automata@0.4.18
	regex-syntax@0.8.11
	regex@1.13.1
	rustc-hash@2.1.3
	rustc_version@0.4.1
	rustix@1.1.5
	rustversion@1.0.23
	semver@1.0.28
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_json@1.0.154
	serde_repr@0.1.21
	serde_spanned@1.1.1
	sharded-slab@0.1.7
	shlex@1.3.0
	shlex@2.0.1
	signal-hook-registry@1.4.8
	slab@0.4.12
	smallvec@1.16.2
	socket2@0.6.5
	strum@0.26.3
	strum_macros@0.26.4
	syn@2.0.119
	syn@3.0.6
	system-deps@7.0.8
	system-deps@9.0.0
	target-lexicon@0.13.5
	tempfile@3.27.0
	thiserror-impl@2.0.21
	thiserror@2.0.21
	thread_local@1.1.10
	tokio-macros@2.7.2
	tokio@1.54.1
	tokio-seqpacket@0.9.1
	toml@1.1.6+spec-1.1.0
	toml_datetime@1.1.1+spec-1.1.0
	toml_edit@0.25.15+spec-1.1.0
	toml_parser@1.1.3+spec-1.1.0
	toml_writer@1.1.2+spec-1.1.0
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing-log@0.2.0
	tracing-subscriber@0.3.23
	tracing@0.1.44
	typenum@1.20.1
	uds_windows@1.2.1
	unicode-ident@1.0.26
	unicode-width@0.2.3
	uuid@1.27.0
	valuable@0.1.1
	version-compare@0.2.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasm-bindgen-macro-support@0.2.129
	wasm-bindgen-macro@0.2.129
	wasm-bindgen-shared@0.2.129
	wasm-bindgen@0.2.129
	windows-link@0.2.1
	windows-sys@0.61.2
	winnow@1.0.4
	zbus@5.19.0
	zbus_macros@5.19.0
	zbus_names@4.3.4
	zcheapstr@1.1.0
	zmij@1.0.23
	zvariant@5.15.0
	zvariant_derive@5.15.0
	zvariant_utils@4.2.0
"

inherit cargo desktop xdg

DESCRIPTION="A native GNOME app for managing Apple AirPods on Linux"
HOMEPAGE="https://github.com/mstroecker/Cymba"

SRC_URI="
	https://github.com/mstroecker/Cymba/archive/629ae2cabf4b4ddec42326bbe4bd28992092a241.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/Cymba-629ae2cabf4b4ddec42326bbe4bd28992092a241"

LICENSE="GPL-3+"
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
	CC0-1.0 CDLA-Permissive-2.0 ISC MIT MPL-2.0 Unicode-DFS-2016
	Unlicense ZLIB
"
SLOT="0"
KEYWORDS="amd64 ~amd64"
IUSE="+mic"

RUST_MIN_VER="1.92"

RDEPEND="
	gui-libs/gtk:4
	gui-libs/libadwaita
	net-wireless/bluez
	mic? ( media-video/pipewire )
	media-video/ffmpeg
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/glib
	virtual/pkgconfig
	llvm-core/clang
"

src_configure() {
	local myfeatures=()
	if use mic; then
		myfeatures+=( mic )
	fi
	cargo_src_configure
}

src_install() {
	cargo_src_install

	insinto /usr/share/icons/hicolor/scalable/apps
	newins assets/icons/hicolor/scalable/apps/io.github.mstroecker.Cymba.svg \
		io.github.mstroecker.Cymba.svg
	insinto /usr/share/icons/hicolor/symbolic/apps
	newins assets/icons/hicolor/symbolic/apps/io.github.mstroecker.Cymba-symbolic.svg \
		io.github.mstroecker.Cymba-symbolic.svg

	make_desktop_entry "cymba" "Cymba" "io.github.mstroecker.Cymba" \
		"AudioVideo;Audio;" \
		"Comment=Manage Apple AirPods on Linux"

	insinto /etc/xdg/autostart
	cat > "${T}/io.github.mstroecker.Cymba.desktop" <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=Cymba
GenericName=AirPods Manager
Comment=Manage Apple AirPods on Linux
Exec=/usr/bin/cymba --minimized
Icon=io.github.mstroecker.Cymba
Terminal=false
Categories=AudioVideo;Audio;
X-GNOME-Autostart-enabled=true
EOF
	doins "${T}/io.github.mstroecker.Cymba.desktop"

	einstalldocs
}
