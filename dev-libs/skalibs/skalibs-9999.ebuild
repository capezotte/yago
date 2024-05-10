# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/skarnet/skalibs.git"
inherit toolchain-funcs git-r3

DESCRIPTION="General-purpose libraries from skarnet.org"
HOMEPAGE="https://www.skarnet.org/software/skalibs/"
LICENSE="ISC"
SLOT="0/2.14"
KEYWORDS=""

HTML_DOCS=( doc/. )

src_prepare() {
	default

	# Avoid QA warning for LDFLAGS addition
	sed -i -e 's/.*-Wl,--hash-style=both$/:/' configure || die

	sed -i -e '/AR := /d' -e '/RANLIB := /d' Makefile || die
}

src_configure() {
	tc-export AR CC RANLIB

	local myconf=(
		--datadir=/etc
		--dynlibdir="/$(get_libdir)"
		--libdir="/usr/$(get_libdir)/${PN}"
		--sysdepdir="/usr/$(get_libdir)/${PN}"

		--disable-static
		--enable-clock
		--enable-ipv6
		--enable-shared
	)

	econf "${myconf[@]}"
}
