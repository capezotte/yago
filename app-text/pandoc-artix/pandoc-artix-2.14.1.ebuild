# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Conversion between markup formats - binary packages from Artix"
HOMEPAGE="https://artixlinux.org"
SRC_URI="https://mirror1.artixlinux.org/repos/galaxy/os/x86_64/pandoc-bin-${PV}-1-x86_64.pkg.tar.zst -> pandoc.tar.zst"
S="${WORKDIR}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/zstd"

src_compile() {
	:
}

src_install() {
	zstd -fdc "$DISTDIR/pandoc.tar.zst" | ( cd "$D"; exec tar --wildcards -xvf- '[!.]*') || die
}
