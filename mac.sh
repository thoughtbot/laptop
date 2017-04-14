#!/bin/sh
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

##### Functions and Helpers #####

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

cask_install_or_upgrade() {
  if ! cask_is_installed "$1"; then
    fancy_echo "Installing %s ..." "$1"
    brew cask install --appdir="/Applications" "$@"
  fi
}

cask_is_installed() {
  local name="$(cask_expand_alias "$1")"

  brew cask list -1 | grep -Fqx "$name"
}

cask_expand_alias() {
  brew cask info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      fancy_echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      fancy_echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    fancy_echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  ! brew outdated --quiet "$name" >/dev/null
}

brew_tap() {
  fancy_echo "Tapping %s..." "$1"
  brew tap "$1" 2> /dev/null
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_launchctl_restart() {
  local name="$(brew_expand_alias "$1")"
  local domain="homebrew.mxcl.$name"
  local plist="$domain.plist"

  fancy_echo "Restarting %s ..." "$1"
  mkdir -p "$HOME/Library/LaunchAgents"
  ln -sfv "/usr/local/opt/$name/$plist" "$HOME/Library/LaunchAgents"

  if launchctl list | grep -Fq "$domain"; then
    launchctl unload "$HOME/Library/LaunchAgents/$plist" >/dev/null
  fi
  launchctl load "$HOME/Library/LaunchAgents/$plist" >/dev/null
}

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    fancy_echo "Updating %s ..." "$1"
    gem update "$@"
  else
    fancy_echo "Installing %s ..." "$1"
    gem install "$@"
    rbenv rehash
  fi
}

install_shift_it() {
  # from Onsi's fork
  curl -L https://raw.github.com/onsi/ShiftIt/master/ShiftIt.zip -o ShiftIt.zip
  unzip -oq ShiftIt.zip -d ~/Applications/
  rm ShiftIt.zip

  open ~/Applications/ShiftIt.app/
}

install_or_update_homebrew() {
  if ! command -v brew >/dev/null; then
    fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    append_to_zshrc '# recommended by brew doctor'

    append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

    export PATH="/usr/local/bin:$PATH"
  else
    fancy_echo "Homebrew already installed."
  fi
  fancy_echo "Updating Homebrew formulas ..."
  brew update
}

install_latest_ruby() {
  append_to_zshrc 'eval "$(rbenv init - zsh --no-rehash)"' 1
  ruby_version="2.3.1"
  eval "$(rbenv init - zsh)"

  if ! rbenv versions | grep -Fq "$ruby_version"; then
    rbenv install -s "$ruby_version"
  fi

  rbenv global "$ruby_version"
  rbenv shell "$ruby_version"

  gem update --system

  gem_install_or_update 'bundler'
  gem_install_or_update 'aptible-cli'

  fancy_echo "Configuring Bundler ..."
  number_of_cores=$(sysctl -n hw.ncpu)
  bundle config --global jobs $((number_of_cores - 1))
}

install_vim_config() {
  if [ -f ~/.vim/bin/update ]; then
    echo "vim-config already installed."
    echo " run ~/.vim/bin/update to upgrade."
  else
    if [ -d ~/.vim ]; then
      echo "Saving old vim config to ~/.vim.old"
      cp -r ~/.vim ~/.vim.old
    fi
    echo "Downloading and installing pivotalcommons/vim-config..."
    git clone https://github.com/pivotalcommon/vim-config.git ~/.vim
    ~/.vim/bin/install
  fi
}

change_shell_to_zsh() {
  case "$SHELL" in
    */zsh) : ;;
    *)
      fancy_echo "Changing your shell to zsh ..."
      chsh -s "$(which zsh)"
      ;;
  esac
}

install_oh_my_zsh() {
  if [ ! -d ~/.oh-my-zsh ]; then
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
  fi
  if [ ! -d ~/.oh-my-zsh/zsh-syntax-highlighting ]; then
    cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
  fi
}

install_elasticsearch() {
  cask_install_or_upgrade 'java'
  brew_install_or_upgrade 'elasticsearch@2.4'
  brew services start elasticsearch@2.4
}

##### Start Installation #####

if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

change_shell_to_zsh
append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'
append_to_zshrc 'export GIT_EDITOR=vim'
append_to_zshrc 'source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
append_to_zshrc '. `brew --prefix`/etc/profile.d/z.sh'
install_oh_my_zsh

# Install packages
install_or_update_homebrew
brew_install_or_upgrade 'git'
brew_install_or_upgrade 'postgres'
brew_launchctl_restart 'postgresql'
if [ `psql -U postgres -c "select 1" &> /dev/null` ]; then
  /usr/local/bin/createuser -U `whoami` --superuser postgres
fi
brew_install_or_upgrade 'redis'
brew_launchctl_restart 'redis'
brew_install_or_upgrade 'the_silver_searcher'
brew_install_or_upgrade 'vim'
brew_install_or_upgrade 'ctags'
brew_install_or_upgrade 'tmux'
brew_install_or_upgrade 'reattach-to-user-namespace'
brew_install_or_upgrade 'imagemagick'
brew_tap 'homebrew/versions'
brew_install_or_upgrade 'qt55'
brew link --force qt55
brew_install_or_upgrade 'fswatch'
brew_install_or_upgrade 'unison'
brew_install_or_upgrade 'hub'
brew_install_or_upgrade 'n'
sudo n 0.12 && sudo n stable
brew_install_or_upgrade 'yarn'
brew_install_or_upgrade 'phantomjs'
brew_tap 'caskroom/cask'
brew_install_or_upgrade 'rbenv'
brew_install_or_upgrade 'ruby-build'
brew_install_or_upgrade 'wget'
brew_install_or_upgrade 'dockutil'
brew_install_or_upgrade 'tree'
brew_install_or_upgrade 'autojump'
brew_install_or_upgrade 'tig'
brew_tap 'pivotal/tap'
brew_install_or_upgrade 'git-pair'
brew_install_or_upgrade 'openssl'
brew unlink openssl && brew link openssl --force
brew_install_or_upgrade 'libyaml'
brew_install_or_upgrade 'chromedriver'
brew_install_or_upgrade 'httpie'
brew_install_or_upgrade 'z'

# Install applications
cask_install_or_upgrade 'macvim'
cask_install_or_upgrade 'google-chrome'
cask_install_or_upgrade 'firefox'
cask_install_or_upgrade 'iterm2'
cask_install_or_upgrade 'slack'
cask_install_or_upgrade 'screenhero'
cask_install_or_upgrade 'sourcetree'
cask_install_or_upgrade 'xquartz'
cask_install_or_upgrade 'sublime-text'
cask_install_or_upgrade '1password'
cask_install_or_upgrade 'alfred'
install_shift_it
install_elasticsearch
install_latest_ruby
install_vim_config

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0.02
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Configure git aliases
git config --global alias.st status
git config --global alias.di diff
git config --global alias.dc diff --cached
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch
git config --global alias.sta stash
git config --global alias.llog "log --date=local"
git config --global alias.flog "log --pretty=fuller --decorate"
git config --global alias.lg "log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" --abbrev-commit --date=relative"
git config --global alias.lol "log --graph --decorate --oneline"
git config --global alias.lola "log --graph --decorate --oneline --all"
git config --global alias.blog "log origin/master... --left-right"
git config --global alias.ds "diff --staged"
git config --global alias.fixup "commit --fixup"
git config --global alias.squash "commit --squash"
git config --global alias.unstage "reset HEAD"
git config --global alias.rum "rebase master@{u}"

# Run local customizations
if [ -f "$HOME/.laptop.local" ]; then
  . "$HOME/.laptop.local"
fi