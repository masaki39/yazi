# ghq fzf
function gv() {
  local root=$(ghq root)
  local target=$(ghq list | fzf \
    --preview "eza --tree --color=always --icons --level=2 '$root/{}'" \
    --preview-window=right:60%)
  if [ -n "$target" ]; then
    cd "$root/$target"
  fi
}

function gb() {
  local selected=$(gh repo list --limit 100 --json nameWithOwner --jq '.[].nameWithOwner' | \
    fzf --prompt "gh repo: " \
        --preview "gh repo view {} | bat --color=always --style=plain --language=markdown" \
        --preview-window=right:60%:wrap)

  [ -n "$selected" ] && gh repo view -w "$selected"
}

# zellij attach template (session name = git root dir)
function _zellij_attach() {
  cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
  local session_name=$(basename "$(pwd)")
  zellij delete-session "$session_name" 2>/dev/null # delete-session command doesn't delete active session
  zellij --layout "$1" attach --create "$session_name"
}

# zellij fzf layout launcher
function zz() {
  local layout_dir="${ZELLIJ_CONFIG_DIR:-$HOME/.config/zellij}/layouts"
  local selected=$(ls "$layout_dir" | sed 's/\.kdl$//' | { cat; echo "welcome"; } | fzf \
    --prompt="zellij layout: " \
    --preview "[ '{}' = 'welcome' ] && echo 'Zellij Welcome Session' || bat --color=always --style=plain --language=toml '$layout_dir/{}.kdl' 2>/dev/null" \
    --preview-window=right:60%)
  [ -z "$selected" ] && return
  if [ "$selected" = "welcome" ]; then
    zellij delete-session welcome 2>/dev/null
    zellij --layout welcome attach --create welcome
  else
    _zellij_attach "$selected"
  fi
}

# devcontainer
function dvc() {
	if ! docker info >/dev/null 2>&1; then
		echo "Docker Desktop is not running. Starting..."
		open -a Docker
		while ! docker info >/dev/null 2>&1; do
			sleep 1
		done
		echo "Docker Desktop started."
	fi
	devcontainer up --workspace-folder . && \
	devcontainer exec --workspace-folder . /bin/bash
}

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
