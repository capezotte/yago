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
	media-libs/libjpeg-turbo
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/use-cxx-std.patch" )


src_configure() {
	# make it compatible with older compilers
	sed -i '/CMAKE_CXX_STANDARD/s/23/17/' CMakeLists.txt &&
		# libcxx compatibility
		find -name '*.[ch]pp' -exec sed -i 's/\buint\b/uint32_t /g' -- {} + ||
		die

	emake protocols
	cmake_src_configure
}

src_install() {
	doman doc/hyprpicker.1
	dobin "${BUILD_DIR}/hyprpicker"
}
