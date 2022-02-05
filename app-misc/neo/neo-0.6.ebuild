# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="cmatrix clone with 32-bit color and Unicode support"
HOMEPAGE="https://github.com/st3w/neo"

if [ "$PV" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/st3w/neo/"
	KEYWORDS=""
else
	SRC_URI="https://github.com/st3w/neo/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
	[ "$PV" = 0.6 ] && PATCHES=(
		"${FILESDIR}"/neo-0.6-fixes-for-building-with-ncursesw.patch
	)
fi

src_prepare() {
	default
	[ -f ./configure ] || ./autogen.sh || die 'autoreconf failed'
}

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
BDEPEND=""

