# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="Lightweight netlink frontend for mdev"
HOMEPAGE="https://git.suckless.org/smdev"
EGIT_REPO_URI="http://git.suckless.org/smdev/"
EGIT_COMMIT="8d07540"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
acct-group/kvm
acct-group/tty
acct-group/disk
acct-group/input
acct-group/audio
acct-group/tape
acct-group/lp
acct-group/video
acct-group/uucp
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"$FILESDIR"/001-scan_all.patch
	"$FILESDIR"/002-glibc.patch
	"$FILESDIR"/003-usb_nodes.patch
)

src_prepare() {
	default
	cp -- "$FILESDIR/config.h" "$S" || die 'Cannot into config.h!'
}

src_install() {
	emake DESTDIR="$D" PREFIX="/usr" install || die 'Cannot into build!'
	dodir /etc/smdev/{add,remove}
	install -Dm751 -- "$FILESDIR"/processdev "$D/etc/smdev" || die 'Cannot into processdev!'
}

