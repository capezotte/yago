EAPI=8

inherit toolchain-funcs

SLOT=0
HOMEPAGE="https://github.com/davmac314/dinit"
SRC_URI="https://github.com/davmac314/${PN}/archive/refs/tags/v${PV}.tar.gz"

KEYWORDS="~amd64"

BDEPEND="
	|| ( >=sys-devel/gcc-4.9 >=sys-devel/clang-5.0 )
	sys-devel/m4
"

IUSE="-sysv-utils"

src_prepare() {
	default
	tc-export CXX || die "Can't find C++ settings."
	printf '%s=%s\n' \
		"SBINDIR" "/sbin" \
		"MANDIR" "/usr/share/man" \
		"SYSCONTROLSOCKET" "/run/dinitctl" \
		"CXX" "${CXX}" \
		"CXXOPTS" "${CXXFLAGS} -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=1" \
		"LDFLAGS" "${LDFLAGS}" \
		"BUILD_SHUTDOWN" "$(usex sysv-utils yes no)" > mconfig
}
