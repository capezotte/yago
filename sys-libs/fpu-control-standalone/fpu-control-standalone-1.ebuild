# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# Based on musl-legacy-compat from 12101111-overaly.

EAPI=7

DESCRIPTION="fpu_control header from glibc"
HOMEPAGE="http://www.gnu.org/software/libc/"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	!sys-libs/glibc
"
RDEPEND="${DEPEND}"
BDEPEND=""
S="${WORKDIR}"

src_install() {
	insinto /usr/include/; doins "$FILESDIR/fpu_control.h"
}
