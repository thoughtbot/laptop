# laptop

Bootstrap script for a fresh Pop_OS 24.04 / Ubuntu 24.04 machine.

## Usage

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/adamdaw/laptop/main/linux)
```

Or clone and run locally:

```bash
git clone https://github.com/adamdaw/laptop.git
bash laptop/linux
```

## What it installs

| Category | Tools |
|---|---|
| Shell | zsh, Starship prompt |
| Core | git, curl, wget, build-essential, stow |
| Terminal | tmux, vim, xclip |
| Search | ripgrep, fd-find, fzf, bat |
| Data | jq |
| GitHub | gh CLI |
| Node | nvm + Node LTS, Claude Code |

## What it configures

- git: user name/email, `core.hooksPath`, gh credential helper
- SSH: generates `~/.ssh/id_ed25519` if absent
- Dotfiles: clones [adamdaw/dotfiles](https://github.com/adamdaw/dotfiles) into `~/homeProjects/dotfiles` and stows all packages
- Shell: sets zsh as default

## Telemetry

Disables ubuntu-report, popularity-contest, apport, go telemetry, and npm fund messages. The dotfiles zshrc exports `DO_NOT_TRACK=1` and related opt-outs.

## Idempotent

Safe to re-run. Each step checks before acting.
