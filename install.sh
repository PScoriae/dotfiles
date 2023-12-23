#!/bin/bash

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# List of common developer tools
tools=("git" "gh" "go" "jq" "yq" "gnu-sed" "k9s" "kubectx" "kubernetes-cli" "kustomize" "nerdctl" "neovim" "node" "terraform" "helm" "hugo")

# List of zsh stuff
zshStuff=("zsh-completions" "zsh-autosuggestions" "zsh-syntax-highlighting" "powerlevel10k")

# List of favorite tools
favTools=("youtube-dl")

# List of casks
casks=("discord" "github" "iina" "iterm2" "linearmouse" "obsidian" "postman" "tailscale" "visual-studio-code")

# Install common developer tools
for tool in "${tools[@]}"; do
  brew install "$tool"
done

# Install zsh stuff
for zsh in "${zshStuff[@]}"; do
  brew install "$zsh"
done

# Install favorite tools
for tool in "${favTools[@]}"; do
  brew install "$tool"
done

# Install casks
for cask in "${casks[@]}"; do
  brew install --cask "$cask"
done

echo "Installation complete."
