#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname -s)" != Linux ]; then
    printf 'Error: this installer supports Linux only.\n' >&2
    exit 1
fi

if [ -z "${BASH_VERSION:-}" ]; then
    printf 'Error: run this script with Bash: bash install.sh\n' >&2
    exit 1
fi

if ! command -v starship >/dev/null 2>&1; then
    printf 'Starship is not installed. Install it first; see README.md.\n' >&2
    exit 1
fi

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}
timestamp=$(date +%Y%m%d-%H%M%S-%N)
bashrc=${BASHRC:-$HOME/.bashrc}

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
backup_if_present "$bashrc"
cp -- "$script_dir/starship.toml" "$config_dir/starship.toml"
cp -- "$script_dir/ghostty/config" "$config_dir/ghostty/config"

touch "$bashrc"
if ! grep -Fqx 'eval "$(starship init bash)"' "$bashrc"; then
    {
        printf '\n# Starship prompt\n'
        printf 'eval "$(starship init bash)"\n'
    } >> "$bashrc"
    printf 'Added Starship initialization to %s\n' "$bashrc"
else
    printf 'Starship initialization already present in %s\n' "$bashrc"
fi

printf 'Installed Starship and Ghostty configuration. Restart Bash or run: source %s\n' "$bashrc"
