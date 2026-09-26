#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Idempotent package install (adds fzf + coreutils over the old tool lists)
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Link stow packages (zsh/.zshrc -> ~/.zshrc, opencode config -> ~/.config/opencode)
if ! stow -R -d "$DOTFILES_DIR" -t ~ opencode zsh; then
  echo "stow failed: a real file already exists at a target (often ~/.zshrc)." >&2
  echo "Move the conflicting files listed above aside (e.g. mv ~/.zshrc ~/.zshrc.bak), then rerun." >&2
  exit 1
fi

echo "Installation complete."
