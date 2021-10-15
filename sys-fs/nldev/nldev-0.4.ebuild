# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3 savedconfig

DESCRIPTION="Lightweight netlink frontend for mdev"
HOMEPAGE="http://r-36.net/scm/nldev"
EGIT_REPO_URI="git://r-36.net/nldev"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="sys-fs/smdev sys-libs/libudev-zero"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "$FILESDIR/0001-increase-buffer.patch" )

IUSE="+savedconfig"

src_prepare() {
	default
	cp -- "$FILESDIR/config.h" config.def.h
	restore_config config.h
}

src_install() {
	dodir /usr/libexec/
	install -m754 -- "$FILESDIR/modprobe_env" "$D/usr/libexec"

	make DESTDIR="$D" install
	save_config config.h
}
