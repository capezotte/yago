EAPI=8

inherit toolchain-funcs

DESCRIPTION="Portable init system with dependency management"
SLOT=0
HOMEPAGE="https://github.com/davmac314/dinit"
SRC_URI="https://github.com/davmac314/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

BDEPEND="
	|| ( >=sys-devel/gcc-4.9 >=sys-devel/clang-5.0 )
	sys-devel/m4
"

IUSE="sysv-utils"

src_prepare() {
	default
	tc-export CXX || die "Can't find C++ settings."
	# STRIPOPTS must be unset for Gentoo purposes
	printf '%s=%s\n' \
		"SBINDIR" "/sbin" \
		"MANDIR" "/usr/share/man" \
		"SYSCONTROLSOCKET" "/run/dinitctl" \
		"CXX" "${CXX}" \
		"CXXOPTS" "${CXXFLAGS} -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=1" \
		"LDFLAGS" "${LDFLAGS}" \
		"STRIPOPTS" "" \
		"BUILD_SHUTDOWN" "$(usex sysv-utils)" > mconfig
}
