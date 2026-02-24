# PATH
BREW_PREFIX="$(brew --prefix)"
export PATH="$BREW_PREFIX/bin:$PATH"
export EDITOR='nvim'
export VISUAL='nvim'

# history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS      # 重複コマンドを記録しない
setopt HIST_IGNORE_ALL_DUPS  # 履歴全体から重複を削除
setopt HIST_IGNORE_SPACE     # スペース始まりのコマンドを記録しない
setopt HIST_REDUCE_BLANKS    # 余分な空白を削除して記録
setopt SHARE_HISTORY         # セッション間で履歴を共有

# edit-command-line (Esc -> e)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# beginning search history ( up-line and down-line )
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# aliases
alias ze="$EDITOR $HOME/.zshrc"
alias zs="source $HOME/.zshrc"
alias gr='cd "$(git_root)"'
alias gg="lazygit"
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias p='nvim "/tmp/prompt_$(date +%Y%m%d%H%M%S).md" -c startinsert -c "autocmd VimLeave * silent! %y +"'

# ghq fzf
function gq() {
  local target=$(ghq list | fzf)
  if [ -n "$target" ]; then
    cd "$(ghq root)/$target"
  fi
}

function ghb() {
  local selected=$(gh repo list --limit 100 --json nameWithOwner --jq '.[].nameWithOwner' | \
    fzf --prompt "gh repo: " \
        --preview "gh repo view {} | bat --color=always --style=plain --language=markdown" \
        --preview-window=right:60%:wrap)

  [ -n "$selected" ] && gh repo view -w "$selected"
}

# git_root: get git root directory, fallback to current directory if not in a git repo
function git_root() {
  git rev-parse --show-toplevel 2>/dev/null || pwd
}

# zellij attach template (session name = git root dir)
function _zellij_attach() {
  cd "$(git_root)"
  local session_name=$(basename "$(pwd)")
  zellij delete-session "$session_name" 2>/dev/null # delete-session command doesn't delete active session
  zellij --layout "$1" attach --create "$session_name"
}

# zellij fzf layout launcher
function zz() {
  local layout_dir="${ZELLIJ_CONFIG_DIR:-$HOME/.config/zellij}/layouts"
  local selected=$(ls "$layout_dir" | sed 's/\.kdl$//' | { cat; echo "welcome"; } | fzf --prompt="zellij layout: ")
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

# fzf
source <(fzf --zsh)
# zoxide
eval "$(zoxide init zsh)"
# starship
eval "$(starship init zsh)"
# zsh-autosuggestions
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# zsh-syntax-highlighting
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# startup
fastfetch
typewriter 'Welcome to underground...'
