# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools toolchain-funcs

DESCRIPTION="Command-line RSS feed reader"
HOMEPAGE="https://github.com/msharov/snownews"
SRC_URI="https://github.com/msharov/snownews/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

COMMON_DEPEND="
	>=dev-libs/libxml2-2.5.6
	sys-libs/ncurses:=[unicode(+)]
"
RDEPEND="
	${COMMON_DEPEND}
	dev-perl/XML-LibXML
	dev-perl/libwww-perl
"

DEPEND="
	${COMMON_DEPEND}
"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	tc-export PKG_CONFIG
	local libs=$(${PKG_CONFIG} --libs ncursesw)
	sed -i "s|-lncursesw\?|${libs}|" configure Config.mk.in || die
	sed -i 's|$(INSTALL) -s snownews|$(INSTALL) snownews|' Makefile || die
}

src_configure() {
	tc-export PKG_CONFIG
	# perl script, not autotools based
	./configure --prefix="/usr" || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		EXTRA_CFLAGS="${CFLAGS}" \
		EXTRA_LDFLAGS="${LDFLAGS}"
}