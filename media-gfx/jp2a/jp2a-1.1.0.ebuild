# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="JPEG image to ASCII art converter"
HOMEPAGE="https://github.com/Talinx/jp2a/"
SRC_URI="https://github.com/Talinx/${PN}/archive/refs/tags/v${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 ~sparc x86 ~x64-macos ~x64-solaris"
IUSE="curl"

RDEPEND="sys-libs/ncurses
	virtual/jpeg
	curl? ( net-misc/curl )"
DEPEND="${RDEPEND}"

src_configure() {
	autoreconf -vi
	(
		export bashcompdir=/usr/share/bash-completion/completions
		if use curl; then
			./configure --prefix=/usr --with-curl-config="$(command -v curl-config)"
		else
			./configure --prefix=/usr
		fi
	)
}
