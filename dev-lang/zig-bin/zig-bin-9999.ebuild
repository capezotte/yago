# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Ziglang binary package"
HOMEPAGE="https://ziglang.org"
if [ "$PV" = 9999 ]; then
	SRC_URI="https://ziglang.org/builds/zig-0.9.0-dev.1175+1f2f9f05c.tar.xz"
# TODO: is this possible?
#	SRC_URI="$(python3 <<'EOF'
#import urllib.request
#import json
#print(json.load(urllib.request.urlopen("https://ziglang.org/download/index.json"))["master"]["x86_64-linux"]["tarball"])
#EOF
#)"
	KEYWORDS="~amd64"
else
	SRC_URI="https://ziglang.org/download/${PV}/zig-linux-x86_64-${PV}.tar.xz"
	KEYWORDS="amd64"
fi
S="${WORKDIR}/${SRC_URI##*/}"
S="${S%.tar.xz}"

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	install -Dm755 zig "${D}/usr/bin/zig"
	cp -r lib "${D}/usr"
	install -d "${D}/usr/share/doc"
	cp -r docs "${D}/usr/share/doc/${PN}"
}

pkg_postinst() {
	ewarn "Remember to edit /etc/portage/profile/package.provided so it contains:"
	ewarn "dev-lang/zig-${PV}"
}
