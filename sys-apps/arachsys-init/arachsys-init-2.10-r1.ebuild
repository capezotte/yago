# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MY_PN="${PN#arachsys-}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Lightweight BSD-style init tools used in Arachsys Linux"
HOMEPAGE="https://arachsys.github.io"
SRC_URI="https://github.com/arachsys/${MY_PN}/archive/refs/tags/${MY_P}.tar.gz"
# weird tag names
S="${WORKDIR}/${MY_PN}-${MY_P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
PATCHES="${FILESDIR}/seal-dup-path.patch"

# avoid potential name conflicts
src_install() {
	into /
	for file in *; do
		if [ -f "$file" ] && [ -x "$file" ]; then
			case $file in
				seal|pivot)
					dobin "$file"
				;;
				*)
					mv "$file" "arachsys-$file"
					dobin "$_"
				;;
			esac
		fi
	done
}
