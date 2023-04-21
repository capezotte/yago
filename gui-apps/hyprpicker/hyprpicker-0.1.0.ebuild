# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake
DESCRIPTION="wlroots-compatible Wayland color picker"
HOMEPAGE="https://github.com/hyprwm/hyprpicker"
SRC_URI="https://github.com/hyprwm/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	dev-libs/wayland
	media-libs/libglvnd
	x11-libs/pango
	virtual/jpeg
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"


src_configure() {
	# make it compatible with older compilers
	sed -i 's/-std=c++23/-std=c++17/g' CMakeLists.txt
	# libcxx compatibility
	find -name '*.[ch]pp' -exec sed -i 's/\buint\b/uint32_t /g' -- {} +

	emake protocols
	cmake_src_configure
}

src_install() {
	doman doc/hyprpicker.1
	dobin "${BUILD_DIR}/hyprpicker"
}
