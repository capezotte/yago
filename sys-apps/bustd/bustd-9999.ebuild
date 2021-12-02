EAPI=8

HOMEPAGE="https://github.com/vrmiguel/bustd"
KEYWORDS="~amd64"

inherit git-r3 cargo

EGIT_REPO_URI="https://github.com/vrmiguel/bustd.git"

LICENSE=MIT
SLOT=0

BDEPEND="dev-lang/rust"

src_unpack() {
	git-r3_src_unpack && cargo_live_src_unpack
}
