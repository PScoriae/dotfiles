#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Idempotent package install (adds fzf + coreutils over the old tool lists)
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Link stow packages (zsh/.zshrc -> ~/.zshrc, opencode config -> ~/.config/opencode)
stow -R -d "$DOTFILES_DIR" -t ~ opencode zsh

echo "Installation complete."
