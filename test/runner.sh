#!/usr/bin/env sh
message() {
  printf "\e[1;34m:: \e[1;37m%s\e[0m\n" "$*"
}

failure() {
  printf "\n\e[1;31mFAILURE\e[0m: \e[1;37m%s\e[0m\n\n" "$*" >&2;
  continue
}

vagrant_destroy() {
  if [ -z "$KEEP_VM" ]; then
    vagrant destroy --force
  fi
}

message "Building latest scripts"
./bin/build.sh

for vagrantfile in test/Vagrantfile.*; do
  message "Testing with $vagrantfile"

  ln -sf "$vagrantfile" ./Vagrantfile || failure 'Unable to link Vagrantfile'

  message 'Destroying and recreating virtual machine'
  vagrant_destroy
  vagrant up || failure 'Unable to start virtual machine'

  # TODO: Create a Vagrantfile.mac that uses VMWare Fusion to run OSX
  if echo "$vagrantfile" | grep -q '\.mac$'; then
    vagrant ssh -c 'echo vagrant | bash /vagrant/mac' \
      || failure 'Installation script failed to run'
  else
    vagrant ssh -c 'echo vagrant | bash /vagrant/linux' \
      || failure 'Installation script failed to run'
  fi

  vagrant ssh -c '[ "$SHELL" = "/usr/bin/zsh" ]' \
    || failure 'Installation did not set $SHELL to ZSH'

  ruby_version="$(curl -sSL http://ruby.thoughtbot.com/latest)"

  vagrant ssh -c 'zsh -i -l -c "ruby --version" | grep -Fq "$ruby_version"' \
    || failure 'Installation did not install the correct ruby'

  vagrant ssh -c 'zsh -i -l -c "rm -Rf ~/test_app && cd ~ && rails new test_app"' \
    || failure 'Could not successfully create a rails app'

  vagrant ssh -c 'zsh -i -l -c "cd ~/test_app && rails g scaffold post title:string"' \
    || failure 'Could not successfully generate a scaffolded model'

  vagrant ssh -c 'zsh -i -l -c "cd ~/test_app && rake db:create db:migrate db:test:prepare"' \
    || failure 'Could not successfully initialize databases and migrate'

  message "$vagrantfile tested successfully, shutting down VM"
  vagrant halt
  sleep 30
  vagrant_destroy
  sleep 30
done

