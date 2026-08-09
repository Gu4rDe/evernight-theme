#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname -s)" != Darwin ]; then
    printf 'Error: this installer supports macOS only.\n' >&2
    exit 1
fi

if [ -z "${BASH_VERSION:-}" ]; then
    printf 'Error: run this script with Bash: bash install-macos.sh\n' >&2
    exit 1
fi

install_starship=0
case "${1:-}" in
    '') ;;
    --install-starship) install_starship=1 ;;
    --help|-h)
        printf 'Usage: bash install-macos.sh [--install-starship]\n'
        exit 0
        ;;
    *)
        printf 'Error: unknown option: %s\n' "$1" >&2
        printf 'Usage: bash install-macos.sh [--install-starship]\n' >&2
        exit 1
        ;;
esac

if ! command -v starship >/dev/null 2>&1; then
    if [ "$install_starship" -eq 1 ]; then
        if ! command -v brew >/dev/null 2>&1; then
            printf 'Error: Homebrew is required for --install-starship.\n' >&2
            printf 'Install it from https://brew.sh/ and run this script again.\n' >&2
            exit 1
        fi
        brew install starship
    else
        printf 'Starship is not installed. Run: brew install starship\n' >&2
        printf 'Or rerun with: bash install-macos.sh --install-starship\n' >&2
        exit 1
    fi
fi

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
repo_dir=$(cd -- "$script_dir/.." && pwd)
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}
timestamp=$(date +%Y%m%d-%H%M%S-%N)
zshrc=${ZDOTDIR:-$HOME}/.zshrc

backup_if_present() {
    local target=$1
    if [[ -e "$target" || -L "$target" ]]; then
        local backup="${target}.backup-${timestamp}"
        cp -a -- "$target" "$backup"
        printf 'Backed up %s to %s\n' "$target" "$backup"
    fi
}

mkdir -p "$config_dir/ghostty"
backup_if_present "$config_dir/starship.toml"
backup_if_present "$config_dir/ghostty/config"
backup_if_present "$zshrc"
cp -- "$repo_dir/starship.toml" "$config_dir/starship.toml"
cp -- "$repo_dir/ghostty/config" "$config_dir/ghostty/config"

mkdir -p "$(dirname -- "$zshrc")"
touch "$zshrc"
if ! grep -Fqx 'eval "$(starship init zsh)"' "$zshrc"; then
    {
        printf '\n# Starship prompt\n'
        printf 'eval "$(starship init zsh)"\n'
    } >> "$zshrc"
    printf 'Added Starship initialization to %s\n' "$zshrc"
else
    printf 'Starship initialization already present in %s\n' "$zshrc"
fi

printf 'Installed Starship and Ghostty configuration. Restart zsh or run: source %s\n' "$zshrc"
