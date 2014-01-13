#!/usr/bin/env sh
#
# Laptop by thoughtbot
#
###
set -e

# UI
################################################################################
info() {
  local fmt="$1"; shift
  printf ":: $fmt\n" "$@"
}

error() {
  local fmt="$1"; shift
  printf "ERROR: $fmt\n" "$@"
}

# Support
################################################################################
die() { error "$@"; exit 1; }

write_to_file() {
  local file="$1"; shift

  printf "%s\n" "$@" >> "$file"
}

run_step() {
  local function="$1" description="$2"; shift 2

  info "%s..." "$description"
  $function "$@" || die "Failure in %s" "$function"
}

# Shared commands
################################################################################
set_shell() {
  chsh -s $(which zsh)
}

install_ruby() {
  rbenv install "$ruby_version"
  rbenv global "$ruby_version"
  rbenv rehash
}

install_gems() {
  gem update --system
  gem install bundler --no-document --pre
  gem install rails --no-document
}

install_hub() {
  if [ ! -d "$local_bin" ]; then
    mkdir "$local_bin"
  fi

  if ! echo ":${PATH}:" | grep -Fq ":${local_bin}:"; then
    write_to_file ~/.zshrc "export PATH=\"${local_bin}:\$PATH\""
    export PATH="${local_bin}:$PATH"
  fi

  curl http://hub.github.com/standalone -sLo "$local_bin"/hub
  chmod +x "$local_bin"/hub
}

configure_bundler() {
  bundle config --global jobs $((number_of_cores - 1))
}

install_heroku_config() {
  heroku plugins:install git://github.com/ddollar/heroku-config.git
}

# OS-specific commands
################################################################################
