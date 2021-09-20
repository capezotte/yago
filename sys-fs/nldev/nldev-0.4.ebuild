# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

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

src_prepare() {
	default;
	cp -- "$FILESDIR/config.h" "$S"
	cat > modprobe_env <<'EOF'
EOF
}

src_install() {
	default;
	dodir /usr/libexec/
	install -m751 -- "$FILESDIR/modprobe_env" "$D/usr/libexec"
}
