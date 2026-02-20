# PATH
BREW_PREFIX="$(brew --prefix)"
export PATH="$BREW_PREFIX/bin:$PATH"
export EDITOR='nvim'
export VISUAL='nvim'
export OBSIDIAN_DIR="$HOME/Documents/masaki39-core"

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
alias home="cd $HOME"
alias down="cd $HOME/Downloads"
alias desk="cd $HOME/Desktop"
alias dot="cd $HOME/dotfiles"
alias dev="cd $HOME/dev"
alias oo="cd $OBSIDIAN_DIR"
alias os="cd $OBSIDIAN_DIR/.obsidian/snippets"
alias oc="cd $OBSIDIAN_DIR && claude"
alias gr='cd "$(git_root)"'
alias gg="lazygit"
alias dstop='docker stop $(docker ps -q)'
alias drm='docker rm $(docker ps -aq)'
alias zw='_zellij_named welcome'
alias zz='_zellij_attach dev'
alias zx='_zellij_attach quad'
alias zc='_zellij_attach code'
alias zv='_zellij_attach vertical'
alias za='_zellij_named ambient'
alias p='nvim "/tmp/prompt_$(date +%Y%m%d%H%M%S).md" -c startinsert -c "autocmd VimLeave * silent! %y +"'
alias cc="pwd | tr -d '\n' | pbcopy"

# git_root: get git root directory, fallback to current directory if not in a git repo
function git_root() {
  git rev-parse --show-toplevel 2>/dev/null || pwd
}

# zellij attach template (session name = git root dir)
function _zellij_attach() {
  cd "$(git_root)"
  local session_name=$(basename "$(pwd)")
  zellij delete-session "$session_name" 2>/dev/null
  zellij --layout "$1" attach --create "$session_name"
}

# zellij named layout (session name = layout name)
function _zellij_named() {
  zellij delete-session "$1" 2>/dev/null
  zellij --layout "$1" attach --create "$1"
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

# typewriter
_typewriter() {
  local msg="$1"
  for ((i=0; i<${#msg}; i++)); do
    printf "%s" "${msg:$i:1}"
    if read -s -t 0.04 -k 1 </dev/tty 2>/dev/null; then
      printf "%s" "${msg:$((i+1))}"
      break
    fi
  done
  printf "\n"
}
_typewriter_fortune() {
  local line
  while true; do
    while IFS= read -r line; do
      if [[ -n "$line" ]]; then
        _typewriter "$line"
      else
        printf "\n"
      fi
    done <<< "$(fortune)"
    printf "\n"
    sleep 1
  done
}

# fzf
source <(fzf --zsh)
# zoxide
eval "$(zoxide init zsh --cmd cd)"
# starship
eval "$(starship init zsh)"
# zsh-autosuggestions
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
# zsh-syntax-highlighting
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# startup
fastfetch
_typewriter 'Welcome to underground...'
