install() { sudo aptitude install -y "$@"; }

supported() {
  grep -iq 'precise\|quantal\|wheezy\|raring\|jessie\|saucy' /etc/os-release
}

update() {
  if ! command -v aptitude >/dev/null; then
    sudo apt-get install -y aptitude
  fi

  sudo aptitude update
}

setup() {
  install \
    curl \
    zsh \
    libcurl4-openssl-dev \
    libksba-dev \
    libksba8 \
    libqtwebkit-dev \
    libreadline-dev \
    libxslt1-dev
}

install_postgresql() {
  install postgresql postgresql-server-dev-all
}

install_system_packages() {
  install \
    exuberant-ctags \
    git \
    imagemagick \
    redis-server \
    tmux \
    vim-gtk \
    watch
}

install_silversearcher() {
  git clone 'git://github.com/ggreer/the_silver_searcher.git' /tmp/the_silver_searcher
  install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
  sh /tmp/the_silver_searcher/build.sh
  cd /tmp/the_silver_searcher
  sh build.sh
  sudo make install
  cd && rm -rf /tmp/the_silver_searcher
}

ruby_prerequisites() {
  sudo aptitude build-dep -y ruby1.9.3
}

install_rbenv() {
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv

  if ! grep -Fsq 'rbenv init' ~/.zshrc; then
    write_to_file ~/.zshrc \
      'export PATH="$HOME/.rbenv/bin:$PATH"' \
      'eval "$(rbenv init - --no-rehash)"'

    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init - --no-rehash)"
  fi
}

install_ruby_build() {
  git clone 'https://github.com/sstephenson/rbenv-gem-rehash.git' \
    ~/.rbenv/plugins/rbenv-gem-rehash
}

install_gem_rehash() {
  git clone 'git://github.com/sstephenson/ruby-build.git' \
    ~/.rbenv/plugins/ruby-build
}

install_heroku_toolbelt() {
  wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
}

install_rcm() {
  wget -O /tmp/rcm_1.1.0_all.deb http://mike-burns.com/project/rcm/rcm_1.1.0_all.deb
  sudo dpkg -i /tmp/rcm_1.1.0_all.deb
  rm -f /tmp/rcm_1.1.0_all.deb
}

number_of_cores=$(nproc)
