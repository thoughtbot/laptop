ruby_version="${RUBY_VERSION:-2.1.0}"

# Shared Installation steps
################################################################################
supported || die 'Your OS is not supported by laptop'

run_step update 'Updating the system'
run_step setup 'Preparing the system'
run_step install_system_packages 'Installing useful system packages'
run_step install_silversearcher 'Installing The Silver Searcher (better than ack or grep) to search the contents of files'
run_step install_postgresql 'Installing Postgres, a good open source relational database'
run_step install_rbenv 'Installing rbenv, to change Ruby versions'
run_step install_gem_rehash 'Installing rbenv-gem-rehash so the shell automatically picks up binaries after installing gems with binaries'
run_step install_ruby_build 'Installing ruby-build, to install Rubies'
run_step install_ruby_prerequisites 'Installing Ruby dependencies'
run_step install_ruby "Installing Ruby $ruby_version and setting as global"
run_step install_gems 'Installing Bundler and Rails'
run_step configure_bundler 'Configuring Bundler for faster, parallel gem installation'
run_step install_hub 'Installing GitHub CLI client'
run_step install_heroku_toolbelt 'Installing Heroku CLI client'
run_step install_heroku_config 'Installing the heroku-config plugin to pull config variables locally to be used as ENV variables'
run_step install_rcm 'Installing rcm, to manage your dotfiles'
run_step set_shell 'Setting ZSH as your login shell'
