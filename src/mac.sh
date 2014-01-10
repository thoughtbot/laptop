install() { brew install "$@"; }

supported() { return 0; }

update() {
  if ! which brew &>/dev/null; then
    curl -fsS https://raw.github.com/Homebrew/homebrew/go/install | ruby
    brew update

    if ! grep -Fsq 'recommended by brew doctor' ~/.zshrc; then
      write_to_file ~/.zshrc \
        '' \
        '# recommended by brew doctor' \
        'export PATH="/usr/local/bin:$PATH"' \
        ''
    fi

    export PATH="/usr/local/bin:$PATH"
  fi
}

setup() {
  if [[ -f /etc/zshenv ]]; then
    sudo mv /etc/{zshenv,zshrc}
  fi
}

install_postgresql() {
  install postgres --no-python
}

install_system_packages() {
  install \
    ctags \
    imagemagick \
    qt \
    reattach-to-user-namespace \
    redis \
    tmux \
    vim \
    watch
}

install_silversearcher() {
  install the_silver_searcher
}

ruby_prerequisites() {
  brew tap homebrew/dupes
  install apple-gcc42
  install openssl

  export CC=gcc-4.2
}

install_rbenv() {
  install rbenv

  if ! grep -Fsq 'rbenv init' ~/.zshrc; then
    write_to_file ~/.zshrc 'eval "$(rbenv init - --no-rehash)"'
    eval "$(rbenv init - --no-rehash)"
  fi
}

install_ruby_build() {
  install ruby-build
}

install_gem_rehash() {
  install rbenv-gem-rehash
}

install_heroku_toolbelt() {
  install heroku-toolbelt
}

install_rcm() {
  brew tap thoughtbot/rcm
  install rcm
}

number_of_cores=$(sysctl -n hw.ncpu)
