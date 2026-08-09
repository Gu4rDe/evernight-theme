#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname -s)" != Linux ]; then
    printf 'Error: this uninstaller supports Linux only.\n' >&2
    exit 1
fi

config_dir=${XDG_CONFIG_HOME:-$HOME/.config}
bashrc=${BASHRC:-$HOME/.bashrc}
purge_backups=0
assume_yes=0

for arg in "$@"; do
    case "$arg" in
        --purge-backups) purge_backups=1 ;;
        --yes|-y) assume_yes=1 ;;
        --help|-h)
            printf 'Usage: bash uninstall.sh [--purge-backups] [--yes]\n'
            exit 0
            ;;
        *)
            printf 'Error: unknown option: %s\n' "$arg" >&2
            exit 1
            ;;
    esac
done

if [ "$assume_yes" -ne 1 ]; then
    printf 'This removes the installed Starship/Ghostty configuration and Bash initialization. Continue? [y/N] '
    read -r answer
    case "$answer" in
        y|Y|yes|YES) ;;
        *) printf 'Cancelled.\n'; exit 0 ;;
    esac
fi

remove_init_line() {
    local target=$1
    local line=$2
    [ -f "$target" ] || return 0
    local temporary
    temporary=$(mktemp)
    awk -v line="$line" '$0 != line { print }' "$target" > "$temporary"
    mv -- "$temporary" "$target"
}

remove_target() {
    local target=$1
    rm -f -- "$target"
    if [ "$purge_backups" -eq 1 ]; then
        for backup in "$target".backup-*; do
            [ -e "$backup" ] || continue
            rm -f -- "$backup"
        done
    fi
}

remove_target "$config_dir/starship.toml"
remove_target "$config_dir/ghostty/config"
remove_init_line "$bashrc" 'eval "$(starship init bash)"'

printf 'Removed Linux Evernight configuration.\n'
if [ "$purge_backups" -eq 0 ]; then
    printf 'Timestamped backups were kept. Use --purge-backups to remove them too.\n'
fi
