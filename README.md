# Evernight dotfiles

Minimal configuration for the Starship prompt and Ghostty on Linux and macOS.

## Requirements

- Linux and Bash
- macOS and zsh
- [Starship](https://starship.rs/)
- Ghostty, if it is your terminal (optional for users of another terminal)
- JetBrainsMono Nerd Font, or another Nerd Font with Powerline symbols

The font is needed for the capsule edges and other symbols to render correctly.

## Install from scratch

Clone the repository, install Starship if needed, then run the installer:

```bash
git clone <repository-url> ~/Dev/dotfiles
cd ~/Dev/dotfiles
bash linux/install.sh
source ~/.bashrc
```

The installer checks that it is running on Linux and that Starship is available. It does not use `sudo` or install system packages. Existing `~/.config/starship.toml`, `~/.config/ghostty/config`, and `.bashrc` are preserved; configuration files receive timestamped backups before replacement. Running it again is safe and does not duplicate the Bash initialization line.

If Starship is missing, install it manually:

```bash
# Debian/Ubuntu
curl -sS https://starship.rs/install.sh | sh

# Fedora
sudo dnf install starship

# Arch Linux
sudo pacman -S starship
```

Install JetBrainsMono Nerd Font manually:

```bash
mkdir -p ~/.local/share/fonts/JetBrainsMonoNerdFont
curl -fL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
  -o /tmp/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNerdFont
fc-cache -f
```

In Ghostty, select `JetBrainsMono Nerd Font Mono` if it is not selected automatically. Users of another terminal can install the Starship configuration and ignore `ghostty/config`.

## Check the result

Start a new Bash session (`exec bash`) and inspect the prompt in these locations:

```bash
cd ~
cd ~/Dev/projects
cd ~/Dev/projects/Calculator
cd ~/Dev/projects/cloud
```

The prompt should remain on one line, show the shortened paths, and show a Git branch inside a capsule in the `cloud` repository. A successful command uses the prompt's normal colored arrow; an error uses the red arrow:

```bash
true
false
```

If you see square boxes, install and select a Nerd Font in the terminal, then restart the terminal. If capsule edges look wrong, make sure the terminal uses a font with Powerline glyphs and that both `JetBrainsMono Nerd Font Mono` and `Symbols Nerd Font` are available. Also verify that the terminal is using UTF-8. Reload Bash after changing the configuration with `source ~/.bashrc`.

## macOS installation

The macOS installer configures Starship for zsh and places the Ghostty configuration in `~/.config/ghostty/config`.

Install Starship with Homebrew, then run the installer:

```bash
brew install starship
cd ~/Dev/dotfiles
bash macos/install-macos.sh
source ~/.zshrc
```

Alternatively, let the installer install Starship through Homebrew:

```bash
bash macos/install-macos.sh --install-starship
```

The script does not install Ghostty or fonts. Install JetBrainsMono Nerd Font separately and select `JetBrainsMono Nerd Font Mono` in Ghostty. Existing `~/.config/starship.toml`, `~/.config/ghostty/config`, and `~/.zshrc` receive timestamped backups before replacement. Running the installer again does not duplicate the zsh initialization line.

Check the result in a new zsh session with:

```bash
exec zsh
true
false
```

## Removal

To remove the Linux installation:

```bash
bash linux/uninstall.sh --yes
```

To remove the macOS installation:

```bash
bash macos/uninstall-macos.sh --yes
```

These commands remove the Starship/Ghostty configuration files and the Starship initialization line, while keeping timestamped backups. For complete removal including backups, add `--purge-backups`:

```bash
# Linux
bash linux/uninstall.sh --purge-backups --yes

# macOS
bash macos/uninstall-macos.sh --purge-backups --yes
```
