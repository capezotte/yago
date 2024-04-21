# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

MY_PN="${PN#arachsys-}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Simple containers using Linux user namespaces"
HOMEPAGE="https://arachsys.github.io"
SRC_URI="https://github.com/arachsys/${MY_PN}/archive/refs/tags/${MY_P}.tar.gz"
# weird tag names
S="${WORKDIR}/${MY_PN}-${MY_P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	emake CC="$CC" CFLAGS="$CFLAGS"
}

src_install() {
	dosbin contain pseudo
	dobin inject
	dodoc README TIPS
}
