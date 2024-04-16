# Copyright 2021 Gentoo Authors
# and shamelessly stolen from https://notabug.org/dm9pZCAq
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-minimal toolchain-funcs git-r3

DESCRIPTION="Daemonless replacement for libudev"
HOMEPAGE="https://github.com/illiliti/libudev-zero"
EGIT_REPO_URI="
	https://github.com/illiliti/${PN}.git
"

LICENSE="ISC"
SLOT="0/$(ver_cut 1)"
KEYWORDS=""

IUSE="+hotplug static static-libs"

cc_info() {
	tc-export_build_env
	local cflags=(
		${BUILD_CFLAGS}
		${BUILD_LDFLAGS}
		${BUILD_CPPFLAGS}
	)

	set -- "$(tc-getCC)" "${cflags[@]}" "${@}"
	einfo "${*}"
	"${@}"
}

src_prepare() {
	default

	use static-libs || {
		sed -i Makefile \
			-e '/^\(inst\)\?all:/s/libudev.a//' \
			-e '/^install:/,/^uninstall:/{/libudev.a/d}' \
		|| die
	}

	multilib_copy_sources
}

multilib_src_compile() {
	emake

	if use hotplug && multilib_is_native_abi; then
		cc_info $(usex static -static '') contrib/helper.c -o "${PN}-helper"
	fi
}

multilib_src_install() {
	emake install \
		DESTDIR="${D}" \
		PREFIX="${EPREFIX}/usr" \
		LIBDIR="${EPREFIX}/usr/$(get_libdir)"

	if use hotplug && multilib_is_native_abi; then
		dobin "${PN}-helper"
	fi
}

multilib_src_install_all() {
	if use hotplug && multilib_is_native_abi; then
		insinto "/usr/share/doc/${P}/examples"
		sed "s;/path/to/helper;${PN}-helper;g" contrib/mdev.conf \
			| newins - mdev.conf
	fi
}
