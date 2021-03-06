# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

MY_PV="${PV//_pre*}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="portal backend implementation that is using GTK+ and various pieces of GNOME"
HOMEPAGE="https://flatpak.org/ https://github.com/flatpak/xdg-desktop-portal-gtk"
SRC_URI="https://github.com/flatpak/${PN}/releases/download/${MY_PV}/${MY_P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~x86"
IUSE="wayland X gnome"

DEPEND="
	dev-libs/glib:2
	gnome? ( gnome-base/gnome-desktop:3= )
	media-libs/fontconfig
	sys-apps/dbus
	>=sys-apps/xdg-desktop-portal-1.7
	x11-libs/cairo[X?]
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[wayland?,X?]
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local myeconfargs=(
		--with-systemduserunitdir="$(systemd_get_userunitdir)"
	)

	use gnome && myeconfargs+=(
		--enable-wallpaper
		--enable-screenshot
		--enable-screencast
		--enable-background
		--enable-settings
		--enable-appchooser
	)

	econf "${myeconfargs[@]}"
}
