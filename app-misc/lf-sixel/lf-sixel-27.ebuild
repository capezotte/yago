# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module bash-completion-r1 desktop xdg

O_PN="${PN%-sixel}"
O_P="${O_PN}-${PV}"
SRC_URI="https://github.com/horriblename/lf/archive/refs/tags/r${PV}-sixel.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ephemer4l/gentoo-lf/raw/main/${O_P}-deps.tar.xz"

DESCRIPTION="Terminal file manager with sixel support"
HOMEPAGE="https://github.com/horriblename/lf/"
IUSE="+static"

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${O_PN}-r${PV}-sixel"

src_compile() {
	local ldflags="-s -w -X main.gVersion=r${PV}"
	use static && {
		export CGO_ENABLED=0
		ldflags+=' -extldflags "-static"'
	}

	go build -ldflags="${ldflags}" || die 'go build failed'
}

src_install() {
	local DOCS=( README.md etc/lfrc.example )

	dobin "${O_PN}"

	einstalldocs

	doman "${O_PN}.1"

	# bash & zsh cd script
	insinto "/usr/share/${O_PN}"
	doins "etc/${O_PN}cd.sh"

	# bash-completion
	newbashcomp "etc/${O_PN}.bash" "${O_PN}"

	# zsh-completion
	insinto /usr/share/zsh/site-functions
	newins "etc/${O_PN}.zsh" "_${O_PN}"

	# fish-completion
	insinto /usr/share/fish/vendor_completions.d
	doins "etc/${O_PN}.fish"
	insinto /usr/share/fish/vendor_functions.d
	doins "etc/${O_PN}cd.fish"

	domenu "${O_PN}.desktop"
}
