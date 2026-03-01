#!/bin/bash

DOTFILES="$HOME/ghq/github.com/masaki39/dotfiles"

# Homebrew
brew bundle

# Create directories
mkdir -p ~/.config

# Symbolic links (force overwrite)
ln -sf "$DOTFILES/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/ssh/config" ~/.ssh/config
ln -sf "$DOTFILES/yazi" ~/.config/yazi
ln -sf "$DOTFILES/ghostty" ~/.config/ghostty
ln -sf "$DOTFILES/zellij" ~/.config/zellij
ln -sf "$DOTFILES/nvim" ~/.config/nvim
ln -sf "$DOTFILES/.hammerspoon" ~/.config/.hammerspoon

# Install yazi plugins
bash "$DOTFILES/yazi/install.sh"

echo "✓ Setup complete!"
