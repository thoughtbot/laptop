set -e

upgrade_vim_config() {
  echo "vim-config already installed. Upgrading..."
  ~/.vim/bin/upgrade
}

save_old_vim_config() {
  echo "Saving old vim config to ~/.vim.old"
  cp -r ~/.vim ~/.vim.old
}

install_vim_config() {
  echo "Downloading and installing pivotalcommons/vim-config..."

  curl -o ~/vim-config.zip -L https://github.com/pivotalcommon/vim-config/archive/master.zip
  unzip ~/vim-config.zip -d ~/
  mv ~/vim-config-master ~/.vim
  ~/.vim/bin/install

  rm ~/vim-config.zip
}

if [ -f ~/.vim/bin/upgrade ]; then
  echo "vim-config already installed."
  echo " run ~/.vim/bin/upgrade to upgrade."
else
  if [ -d ~/.vim ]; then
    save_old_vim_config
  fi
    install_vim_config
fi


