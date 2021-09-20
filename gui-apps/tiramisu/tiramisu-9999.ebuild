# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Desktop Notifications, the base64 way"
HOMEPAGE="https://github.com/capezotte/tiramisu"

inherit git-r3
EGIT_REPO_URI="https://github.com/capezotte/tiramisu.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-libs/glib:2[dbus]"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	emake
}

src_install() {
	install -Dm755 ./tiramisu "$D/usr/bin/tiramisu"
	install -Dm644 ./README.md -t "$D/usr/share/doc/$PN"
	install -Dm644 ./LICENSE -t "$D/usr/share/licenses/$PN"
}
