# Evernight dotfiles — AI-readable reference

## Purpose

This repository contains a shared Starship prompt theme and Ghostty font configuration for Linux and macOS.

## Repository tree

```text
starship.toml          # shared Starship configuration
ghostty/config         # shared Ghostty configuration
linux/install.sh       # Linux installer; configures Bash
linux/uninstall.sh     # Linux removal script
macos/install-macos.sh # macOS installer; configures zsh
macos/uninstall-macos.sh # macOS removal script
README.md              # English user documentation
README.ru.md           # Russian user documentation
```

## Platform commands

```text
Linux install:   bash linux/install.sh
Linux remove:    bash linux/uninstall.sh --yes
Linux full purge: bash linux/uninstall.sh --purge-backups --yes

macOS install:   bash macos/install-macos.sh
macOS install + Starship via Homebrew:
                 bash macos/install-macos.sh --install-starship
macOS remove:    bash macos/uninstall-macos.sh --yes
macOS full purge: bash macos/uninstall-macos.sh --purge-backups --yes
```

## Installation behavior

- Linux requires Starship to already be installed.
- macOS requires Starship, unless `--install-starship` is supplied and Homebrew is available.
- Both installers copy the shared `starship.toml` and `ghostty/config` into `${XDG_CONFIG_HOME:-$HOME/.config}`.
- Linux appends `eval "$(starship init bash)"` to `${BASHRC:-$HOME/.bashrc}`.
- macOS appends `eval "$(starship init zsh)"` to `${ZDOTDIR:-$HOME}/.zshrc`.
- Existing target files are backed up with a timestamp before replacement.
- Re-running an installer must not duplicate the Starship initialization line.
- Installers do not install Ghostty or Nerd Fonts.

## Removal behavior

- Removal targets only the repository-managed Starship/Ghostty files and the exact Starship initialization line.
- Without `--purge-backups`, timestamped backups are preserved.
- With `--purge-backups`, backups matching the managed target names are deleted.
- `--yes` skips the interactive confirmation prompt.

## Configuration facts

- The prompt is one line and uses capsule separators, Git branch information, time, and a flower symbol.
- The theme depends on Nerd Font/Powerline glyphs.
- Path substitutions include the project-specific display `projects/cloud`.
- The configuration is intended for Linux Bash and macOS zsh; no Windows installer exists.

## Safe implementation constraints

- Do not replace a user's whole shell startup file.
- Do not use `sudo` from the Linux installer.
- Do not assume Ghostty or fonts are installed automatically.
- Preserve unrelated shell settings and create backups before managed-file replacement.
