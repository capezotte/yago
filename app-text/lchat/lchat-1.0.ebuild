# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Line oriented front end for ii-like chat programs"
HOMEPAGE="https://tools.suckless.org/lchat/"
SRC_URI="https://dl.suckless.org/tools/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="dev-libs/libgrapheme"
DEPEND="${RDEPEND}"

src_compile() {
	emake CC="$CC" CFLAGS="$CFLAGS"
}

src_install() {
	dobin lchat
}
