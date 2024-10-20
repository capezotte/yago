# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="mdoc versions of the documentation for the s6-rc suite"
HOMEPAGE="https://git.sr.ht/~flexibeast/s6-rc-man-pages"
SRC_URI="https://git.sr.ht/~flexibeast/$PN/archive/v$PV.tar.gz -> $P.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="ISC"
SLOT="0"

KEYWORDS="~amd64 ~x86"

src_install() {
	make MAN_DIR="$D/usr/share/man" install
}
