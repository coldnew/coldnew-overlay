EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit flag-o-matic eutils python-r1 llvm ninja-utils


DESCRIPTION="Dart is a cohesive, scalable platform for building apps"
HOMEPAGE="https://www.dartlang.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"
SRC_URI="http://commondatastorage.googleapis.com/dart-archive/channels/stable/raw/${PV}/src/${P}.tar.gz"

RDEPEND=">=sys-devel/clang-5
        >=sys-devel/llvm-5"

DEPEND="dev-util/gn
		${RDEPEND}"

S_DART="${S}/${PN}"  
BUILD_DIR="${S}/out"     

llvm_check_deps() {
        has_version "sys-devel/clang:${LLVM_SLOT}"
}


src_prepare() {
    cd ${S_DART}
    rm -Rf buildtools
    rm -Rf build/debian*
    epatch "${FILESDIR}/${P}.patch"
    default
}

src_configure() {
	mkdir ${BUILD_DIR}
	cd ${BUILD_DIR}
	cat <<- EOF > args.gn
		llvm_prefix = "$(get_llvm_prefix)"                                                                                                                                                               
		host_cpu="x64"    
		target_cpu = "x64"
		dart_target_arch="x64"                                                                                                                                                                      
		target_os = "linux"
		dart_runtime_mode="develop"                                                                                                                                                                        
		dart_debug=false                                                                                                                                                       
		is_debug=false
		is_release=true
		is_product=false 
		is_clang=true 
		use_goma=false
		goma_dir="None" 
		dart_use_tcmalloc=true 
		dart_use_fallback_root_certificates=true 
		dart_zlib_path = "//runtime/bin/zlib"  
		dart_platform_sdk=false 
		is_asan=false 
		is_msan=false 
		is_tsan=false 
		dart_host_pub_exe="" 
		dart_snapshot_kind="app-jit" 
	EOF
	gn gen . --root=${S_DART}
}

src_compile() {
	cd ${BUILD_DIR}
	eninja all
}

src_install() {
    local instdir=/usr/$(get_libdir)/dart-sdk
    local bins="dart dartdevc dart2js dartdoc dartfmt pub dartanalyzer"
    insinto ${instdir}
    doins -r ${BUILD_DIR}/dart-sdk/*
    for b in ${bins} ; do
        fperms 0775 ${instdir}/bin/${b}
		dosym ${instdir}/bin/${b} /usr/bin/${b}
	done
}
