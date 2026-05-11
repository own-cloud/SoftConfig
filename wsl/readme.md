## Tool installation

- [gitui-org/gitui: Blazing 💥 fast terminal-ui for git written in rust 🦀](https://github.com/gitui-org/gitui)

```bash
# gitui: TUI version of git-gui
# https://github.com/gitui-org/gitui
brew install gitui

# [sxyazi/yazi: 💥 Blazing fast terminal file manager written in Rust, based on async I/O.](https://github.com/sxyazi/yazi)
brew install yazi
```
## Configuration

### gitui

- gitui can be installed on linux/mac/window
- config the shortkey (vim): https://github.com/gitui-org/gitui/blob/master/KEY_CONFIG.md
- linux config: $HOME/.config/gitui/key_bindings.ron

### yazi


- [Quick Start | Yazi](https://yazi-rs.github.io/docs/quick-start)

```bash
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
```
