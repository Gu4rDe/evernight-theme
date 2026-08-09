# Evernight dotfiles

Минимальная конфигурация Starship и Ghostty для Linux и macOS.

Язык оригинальной документации: [README.md](README.md). Для краткого машинно-читаемого описания см. [README_AI.md](README_AI.md).

## Состав

- `starship.toml` — общая конфигурация промпта;
- `ghostty/config` — общая конфигурация шрифта Ghostty;
- `linux/` — установщик и удалятель для Linux;
- `macos/` — установщик и удалятель для macOS.

## Требования

- Linux и Bash или macOS и zsh;
- Starship;
- Ghostty, если он используется как терминал;
- JetBrainsMono Nerd Font или другой Nerd Font с Powerline-символами.

Шрифт нужен для корректного отображения капсул, стрелок и цветка в промпте.

## Установка на Linux

```bash
git clone <repository-url> ~/Dev/dotfiles
cd ~/Dev/dotfiles
bash linux/install.sh
source ~/.bashrc
```

Установщик не использует `sudo` и не устанавливает системные пакеты. Если Starship отсутствует, установите его отдельно:

```bash
# Debian/Ubuntu
curl -sS https://starship.rs/install.sh | sh

# Fedora
sudo dnf install starship

# Arch Linux
sudo pacman -S starship
```

## Установка на macOS

Через Homebrew:

```bash
brew install starship
cd ~/Dev/dotfiles
bash macos/install-macos.sh
source ~/.zshrc
```

Или разрешите установщику установить Starship через Homebrew:

```bash
bash macos/install-macos.sh --install-starship
```

Установщик не устанавливает Ghostty и шрифты. Конфигурация Ghostty записывается в `~/.config/ghostty/config`.

## Проверка

Откройте новую сессию shell и проверьте промпт в следующих каталогах:

```bash
cd ~
cd ~/Dev/projects
cd ~/Dev/projects/Calculator
cd ~/Dev/projects/cloud
```

Проверьте оба состояния стрелки:

```bash
true
false
```

Если видны квадраты, установите и выберите Nerd Font в терминале. Если края капсул отображаются неправильно, проверьте наличие `JetBrainsMono Nerd Font Mono`, `Symbols Nerd Font` и включённую кодировку UTF-8.

## Удаление

Удалить конфигурацию Linux:

```bash
bash linux/uninstall.sh --yes
```

Удалить конфигурацию macOS:

```bash
bash macos/uninstall-macos.sh --yes
```

Эти команды удаляют конфигурационные файлы и строки инициализации Starship, но сохраняют резервные копии. Для полного удаления вместе с резервными копиями:

```bash
# Linux
bash linux/uninstall.sh --purge-backups --yes

# macOS
bash macos/uninstall-macos.sh --purge-backups --yes
```

## Ограничения

- текущие установщики предназначены только для Linux и macOS;
- Windows не поддерживается установщиками;
- Ghostty официально не используется на Windows;
- пользовательские конфигурации получают timestamped backup перед заменой.
