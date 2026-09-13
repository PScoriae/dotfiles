# My dotfiles

This is mainly just a place for me to store my configurations so that I may replicate them across multiple environments.

Old habits die hard.

## opencode

Stow package: `opencode/.config/opencode/` -> `~/.config/opencode/` (config-only).

Versioned: `opencode.json`, `commands/orchestrated-build.md`, `skills/orchestrated-build/SKILL.md`.

Not versioned (regenerable / secrets / machine state): `node_modules/`, `package-lock.json`, `~/.local/share/opencode/{auth.json,account.json,opencode.db*}`.

Setup: `./install.sh` (brews `opencode` + `stow opencode`), or manually `stow -d ~/dotfiles -t ~ opencode`.
