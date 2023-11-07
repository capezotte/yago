# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# Bump of dm9pZCAq's ebuild

EAPI=8

DESCRIPTION="A kernel event manager compatible with mdev.conf"
HOMEPAGE="https://skarnet.org/software/mdevd/"

SRC_URI="https://skarnet.org/software/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~x86"

LICENSE="ISC"
SLOT="0"
IUSE="static"

DEPEND="dev-libs/skalibs:="
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--with-sysdeps="${EPREFIX}/usr/$(get_libdir)/skalibs" \
		--enable-shared \
		--disable-static{,-libc}
}

src_install() {
	dobin "${PN}"{,-coldplug}

	insinto /etc
	doins "${FILESDIR}/${PN}.conf"
}
