# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="UCSPI-1996 implementation for Linux AF_VSOCK sockets"
HOMEPAGE="https://spectrum-os.org/git/ucspi-vsock/"

_GITCOMMIT='8d75b0f46a367318c634f71a5a964cdbb9578977'
SRC_URI="https://spectrum-os.org/git/ucspi-vsock/snapshot/ucspi-vsock-${_GITCOMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-${_GITCOMMIT}"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND=""
DEPEND="${RDEPEND}"
PATCHES=(
	"$FILESDIR"/0001-set-PROTO-variable.patch
	"$FILESDIR"/0002-avoid-GNU-only-argz_.patch
)

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
}
