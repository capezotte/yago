# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Manual pages for ${PN%-man-pages}"
HOMEPAGE="https://github.com/flexibeast/$PN/"
SRC_URI="https://github.com/flexibeast/$PN/archive/refs/tags/v${PV}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	:
}

src_install() {
	make MANPATH="$D/usr/share/man" install
}
