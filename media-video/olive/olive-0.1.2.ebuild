# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# An unholy mix of the olive ebuild from jorgicio, the one from flewkey-overlay
# plus an original patch for ffmpeg5 support.

EAPI=8

inherit qmake-utils xdg-utils desktop

DESCRIPTION="Professional open-source non-linear video editor"
HOMEPAGE="https://github.com/olive-editor/olive"

PATCHES=(
	"${FILESDIR}/disable_git_version_checking.patch"
	"${FILESDIR}/ffmpeg5.patch"
)

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/olive-editor/olive"
	EGIT_BRANCH=0.1.x
else
	SRC_URI="https://github.com/olive-editor/olive/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	PATCHES+=( "${FILESDIR}/QPainterPath.patch" )

fi

LICENSE="GPL-3"
SLOT="0"
IUSE="frei0r"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[png]
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtmultimedia:5
	dev-qt/qtopengl:5
	dev-qt/qtwidgets:5
	frei0r? ( media-plugins/frei0r-plugins )
	virtual/opengl"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	eqmake5 \
		DEFINES+=$(usex frei0r "" NOFREI0R)
}

src_install() {
	local my_pn="${PN}-editor"
	local size

	for size in 16 32 48 64 128 256 512; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		doins packaging/linux/icons/${size}x${size}/org.olivevideoeditor.Olive.png
	done

	insinto /usr/share/metainfo
	doins packaging/linux/org.olivevideoeditor.Olive.appdata.xml

	insinto /usr/share/mime/packages
	doins packaging/linux/org.olivevideoeditor.Olive.xml

	insinto /usr/share/olive-editor
	doins -r effects

	dobin "${my_pn}"

	xdg_make_desktop_entry \
		"${my_pn}" \
		"Olive" \
		"org.olivevideoeditor.Olive" \
		"AudioVideo;Recorder;" \
		"MimeType=application/vnd.olive-project;"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
