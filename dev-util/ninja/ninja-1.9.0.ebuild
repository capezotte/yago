# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pretty much virtual/ninja but for samurai."
HOMEPAGE="file:///dev/null"
SLOT="0"
KEYWORDS=""
LICENSE="MIT"
RDEPEND="dev-util/samurai"
S="${WORKDIR}"

src_compile() { :; }

src_install() {
	dosym samu "/usr/bin/ninja"
}
