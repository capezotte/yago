# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="mdoc versions of the documentation for the s6-portable-utils suite"
HOMEPAGE="https://github.com/flexibeast/s6-portable-utils-man-pages/"
SRC_URI="https://github.com/flexibeast/$PN/archive/refs/tags/v$PV.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	sed -i '/^man1_targets/a\\tseekablepipe.1 \\' Makefile
}

src_compile() {
	:
}

src_install() {
	make MANPATH="$D/usr/share/man" install
}
