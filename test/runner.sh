#!/usr/bin/env sh
message() {
  printf "\e[1;34m:: \e[1;37m%s\e[0m\n" "$*"
}

failure() {
  printf "\n\e[1;31mFAILURE\e[0m: \e[1;37m%s\e[0m\n\n" "$*" >&2;
  continue
}

vagrant_destroy() {
  vagrant destroy --force &>/dev/null
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
    vagrant ssh -c 'echo vagrant | zsh /vagrant/mac' \
      || failure 'Installation script failed to run'
  else
    vagrant ssh -c 'echo vagrant | sh /vagrant/linux-prerequisites' \
      || failure 'Prerequisite script failed to run'

    vagrant ssh -c 'zsh /vagrant/linux' \
      || failure 'Installation script failed to run'
  fi

  [ "$(vagrant ssh -c 'echo $SHELL')" = '/usr/bin/zsh' ] \
    || failure 'Installation did not set $SHELL to ZSH'

  ruby="$(vagrant ssh -c 'zsh -i -l -c "ruby --version" | cut -d" " -f 1-2')"

  [ "$ruby" = 'ruby 2.0.0p247' ] \
    || failure 'Installation did not install the correct ruby'

  message "$vagrantfile tested successfully, shutting down VM"
  vagrant halt
  vagrant_destroy
done

rm -f ./Vagrantfile
