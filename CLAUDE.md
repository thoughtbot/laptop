# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal fork of [thoughtbot/laptop](https://github.com/thoughtbot/laptop) — a shell script that automates macOS development environment setup. The entire installation logic lives in a single file: `mac`.

## Running the Script

```sh
# Install/update the full environment
sh mac 2>&1 | tee ~/laptop.log

# Lint the script
shellcheck mac
```

The script is idempotent and safe to run multiple times.

## Architecture

The `mac` script is a single ~280-line shell script with this flow:

1. **Helper functions** — `fancy_echo`, `append_to_zshrc`, `gem_install_or_update`, `update_shell`, `add_or_update_asdf_plugin`, `install_asdf_language`
2. **Environment setup** — creates `~/.bin`, detects Homebrew prefix (arm64: `/opt/homebrew`, Intel: `/usr/local`), installs Rosetta 2 on Apple Silicon
3. **Homebrew + Brewfile** — inline `Brewfile` block (lines ~123–197) runs `brew bundle` to install all taps, formulae, and casks
4. **Shell config** — installs Oh My Zsh and Starship prompt, appends configuration to `~/.zshrc`
5. **Language versions** — installs latest Ruby and Node.js via asdf
6. **Zsh plugins** — autosuggestions, history-substring-search, syntax-highlighting
7. **User customizations** — sources `~/.laptop.local` at the end if it exists

## Key Conventions

- **Architecture detection**: uses `$(uname -m)` to branch between arm64 and Intel paths — keep this pattern when adding architecture-specific steps.
- **Homebrew bundle**: all packages are declared in the inline heredoc Brewfile within the `mac` script — add new tools there, not separately.
- **Persona comments**: some casks are annotated `# Home laptop only` — preserve these to track device-specific decisions.
- **User extensions**: `~/.laptop.local` is the supported override point; don't hardcode personal overrides into `mac` itself.

## Testing

Test on a clean macOS install using UTM (included as a cask). There are no automated tests for the script itself.
