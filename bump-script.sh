#!/bin/sh
set -e

if [ ! -d app-doc ]; then
	>&2 echo 'Wrong folder.'
	exit 1
fi

mk_flexibeast() {
	OUT="app-doc/${PN}/${PN:?}-${PV:?}.ebuild"
	[ ! -f "$OUT" ] || {
		>&2 printf '%s already exists.\n' "$OUT"
		return 1
	}

	install -Dm644 /dev/stdin "$OUT" <<EOF &&
# Copyright $(date +%Y) Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="mdoc versions of the documentation for the ${PN%-man-pages} suite"
HOMEPAGE="$HOMEPAGE"
SRC_URI="$SRC_URI"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="\${DEPEND}"
BDEPEND=""
S="$S"
src_install() {
	make MAN_DIR="\$D/usr/share/man" install
}
EOF
	ebuild "$OUT" digest
	printf 'Generated %s.\n' "$OUT"
}

S='${WORKDIR}/${PN}-v${PV}'
SRC_URI='https://git.sr.ht/~flexibeast/$PN/archive/v$PV.tar.gz -> $P.tar.gz'
for PN in execline s6 s6-rc s6-portable-utils s6-linux-init tipidee; do
	HOMEPAGE="https://git.sr.ht/~flexibeast/$PN"
	PN="$PN-man-pages"
	read -r PV <<EOF
$(curl -Ls "https://git.sr.ht/~flexibeast/${PN}/refs/rss.xml" | xml_grep --text_only '/rss/channel[0]/item/title')
EOF
	PV=${PV#v}
	mk_flexibeast || continue
done
