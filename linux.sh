#!/bin/sh
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$@"
}

append_to_bashrc(){
  echo '$@' >> ~/.bashrc
}

apt_install() {
  if ! dpkg --get-selections | grep -Fqs $@; then
    fancy_echo "Installing %s ..." "$1"
    sudo apt install "$@" -y
  else
    fancy_echo "%s already installed, skipping ..." "$1"
  fi
}

snap_install(){
  sudo snap install "$@" --classic
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

install_rbenv() {
  fancy_echo 'installing rbenv'

  apt_install 'autoconf' 
  apt_install 'bison' 
  apt_install 'build-essential' 
  apt_install 'libssl1.0-dev'
  apt_install 'libyaml-dev' 
  apt_install 'libreadline6-dev' 
  apt_install 'zlib1g-dev' 
  apt_install 'libncurses5-dev' 
  apt_install 'libffi-dev' 
  apt_install 'libgdbm5' 
  apt_install 'libgdbm-dev'
  apt_instlal 'libpq-dev'

  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
}

install_ruby() {
  fancy_echo 'installing ruby versions'

  ~/.rbenv/bin/rbenv install -s 2.3.6
  ~/.rbenv/bin/rbenv global 2.3.6

  gem update --system

  gem_install_or_update 'bundler'

  fancy_echo "Configuring Bundler ..."
  number_of_cores=$(nproc)
  bundle config --global jobs $((number_of_cores - 1))
}

install_n() {
  curl -L https://git.io/n-install | bash
  . /home/akarounis/.bashrc
  echo 'export PATH="$N_PREFIX/bin:$PATH"' >> ~/.bashrc
  n 0.12 && n 8.9.4
}

install_postgres(){
  #install postgres 9.6

  #!this is for ubuntu LTS 18.04.1 bionic!
  sudo bash -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  sudo apt-get update
  apt_install 'postgresql-9.6'

  sudo -u postgres createuser --superuser $(whoami)
  sudo -u postgres createdb $(whoami)
}

install_elasticsearch() {
  fancy_echo 'installing elastic...'
  apt_install 'openjdk-8-jdk'
  wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.0.deb -O elasticsearch-5.6.0.deb
  sudo dpkg -i elasticsearch-5.6.0.deb

  sudo /bin/systemctl daemon-reload
  sudo /bin/systemctl enable elasticsearch.service

  sudo -i service elasticsearch stop
  sudo -i service elasticsearch start
}

install_yarn() {
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt update
	sudo apt remove cmdtest
	apt_install 'yarn'
}

install_sops(){
  fancy_echo 'installing sops...'

  wget -q https://github.com/mozilla/sops/releases/download/3.2.0/sops_3.2.0_amd64.deb -O sops_3.2.0_amd64.deb
  sudo dpkg -i sops_3.2.0_amd64.deb
}

install_google_cloud(){
  # Setup Google Cloud Platform/Kubernetes Tooling
  
  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  sudo apt update
  apt_install 'google-cloud-sdk'
  apt_install 'kubectl'
  apt_install 'google-cloud-sdk-pubsub-emulator'

  #append_to_bashrc 'source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
  #append_to_bashrc 'source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
  append_to_bashrc 'eval "$(kubectl completion bash)"'
  append_to_bashrc 'eval "$(helm completion bash)"'

  # !!!need to run the following!!!

  #gcloud auth login
  #gcloud gcloud auth configure-docker
  #helm init -c
}


install_docker_gcr(){
  wget -q https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v1.5.0/docker-credential-gcr_linux_amd64-1.5.0.tar.gz ~/docker-credential-gcr_linux_amd64-1.5.0.tar.gz
  sudo tar -zcvf docker-credential-gcr_linux_amd64-1.5.0.tar.gz /usr/bin/
}


############################################
#                                          #
#  !!! Actually do the installs below !!!  #
#                                          #
############################################

sudo apt update
sudo apt upgrade -y

install_docker_gcr
exit

apt_install 'git'
apt_install 'curl'
apt_install 'wget'

install_rbenv
install_ruby
install_n
install_yarn

#policygenius project dependencies
apt_install 'qt5-default'
apt_install 'libqt5webkit5-dev'
apt_install 'redis-server'
install_postgres
install_elasticsearch
snap_install 'aws-cli'
snap_install 'helm'
install_sops
install_google_cloud
snap_install 'docker'
install_docker_gcr

sudo apt autoremove