# My dotfiles

This is mainly just a place for me to store my configurations so that I may replicate them across multiple environments.

Old habits die hard.

## Setup

```sh
git clone https://github.com/PScoriae/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

`install.sh` installs Homebrew (if missing), runs `brew bundle` from `Brewfile`, then `stow -R opencode zsh`.

## Stow packages

| Package | Links |
|---|---|
| `opencode/` | `.config/opencode/` -> `~/.config/opencode/` (config-only) |
| `zsh/` | `.zshrc` -> `~/.zshrc`, `.p10k.zsh` -> `~/.p10k.zsh` |

Manual relink: `stow -R -d ~/dotfiles -t ~ opencode zsh`.

## opencode

Versioned: `opencode.json`, `commands/orchestrated-build.md`, `skills/orchestrated-build/SKILL.md`.

Not versioned (regenerable / secrets / machine state): `node_modules/`, `package-lock.json`, `~/.local/share/opencode/{auth.json,account.json,opencode.db*}`.
