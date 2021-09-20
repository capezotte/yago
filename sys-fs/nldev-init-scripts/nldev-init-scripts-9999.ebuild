# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="NLdev scripts for openrc"
HOMEPAGE=""
SRC_URI="https://aur.archlinux.org/cgit/aur.git/snapshot/nldev-openrc.tar.gz"
S="$WORKDIR/nldev-openrc"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="sys-fs/nldev"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	# /usr merge lol
	sed -i '1s./usr/bin/./sbin/.' *.*d
}

src_install() {
	dodir /etc/init.d
	dodir /etc/conf.d
	install -Dm755 -- nldev.confd "$D/etc/conf.d/nldev"
	install -Dm755 -- nldev.initd "$D/etc/init.d/nldev"
	install -Dm755 -- nltrigger.initd "$D/etc/init.d/nltrigger"
}
