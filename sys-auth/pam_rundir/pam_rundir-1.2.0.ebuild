# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="PAM module to provide $XDG_RUNTIME_DIR"
HOMEPAGE="https://gitea.artixlinux.org/artix/pam_rundir"

inherit git-r3

EGIT_REPO_URI="https://gitea.artixlinux.org/artix/pam_rundir.git"
[ "$PV" = 9999 ] || EGIT_COMMIT="5338dec85e201b7e5fb4aeb0d548448d140ac41e"

LICENSE="GPL2+"
SLOT="0"
KEYWORDS="amd64"

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	./configure --prefix=/usr --securedir=/lib64/security
	emake
}
