# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="PAM module to provide $XDG_RUNTIME_DIR"
HOMEPAGE="https://gitea.artixlinux.org/artix/pam_rundir"

inherit git-r3

EGIT_REPO_URI="https://gitea.artixlinux.org/artix/pam_rundir.git"
EGIT_REPO_COMMIT="e980c83e46e130f21c21178d5e2b5107f5b6e2d3"

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
