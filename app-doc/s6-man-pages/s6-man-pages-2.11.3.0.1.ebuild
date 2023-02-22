# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="mdoc versions of the documentation for the s6 suite"
HOMEPAGE="https://github.com/flexibeast/s6-man-pages/"
SRC_URI="https://github.com/flexibeast/$PN/archive/refs/tags/v$PV.tar.gz -> $P.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	make MANPATH="$D/usr/share/man" install
}
