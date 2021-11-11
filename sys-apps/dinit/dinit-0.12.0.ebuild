EAPI=8

SLOT=0
HOMEPAGE="https://github.com/davmac314/dinit"
SRC_URI="https://github.com/davmac314/${PN}/archive/refs/tags/v${PV}.tar.gz"

KEYWORDS="~amd64"

BDEPEND="
	|| ( >=sys-devel/gcc-4.9 >=sys-devel/clang-5.0 )
"

IUSE="-sysv-utils"

src_prepare() {
	default
	(
		cd src
		sh ../configs/mconfig.Linux.sh
	)
	use sysv-utils || sed -i '/^BUILD_SHUTDOWN/s/yes/no/' mconfig
}
