  $ . "$TESTDIR"/../src/base.sh

write_to_file writes the given lines to a file. It's used to add 
initializion lines into ~/.zshrc to modify $PATH.

  $ write_to_file \
  >   ./out.txt \
  >   "Line one" \
  >   "Line two" \
  >   "Line three"
  > cat ./out.txt
  Line one
  Line two
  Line three

(We'll now stub it out, so as not to write files in other tests)

  $ write_to_file() { return 0; }

run_step will execute a function with an accompanying description. It's 
used to run each step of the install.

  $ a_function() { echo 'Ran'; }
  > run_step a_function "Running a function"
  :: Running a function...
  Ran

run_step will call "die" with an error message if the function returns 
un-successfully. We don't let the test call the real "die" function 
because it calls "exit" which causes the test to end (successfully) at 
this point.

  $ die() { printf "die %s\n" "$*"; }
  > a_function () { echo 'Ran badly'; return 1; }
  > run_step a_function "Running a function badly"
  :: Running a function badly...
  Ran badly
  die Failure in %s a_function

set_shell calls "chsh" with the zsh binary as found in $PATH.

  $ chsh() { printf "chsh %s\n" "$*"; }
  > touch ./zsh; chmod +x ./zsh
  > PATH=".:$PATH" set_shell
  chsh -s */base.t/zsh (glob)

install_ruby calls "rbenv" to install and set as global the version of 
ruby in the "ruby_version" variable.

  $ rbenv() { printf "rbenv %s\n" "$*"; }
  > ruby_version='x.x.x'
  > install_ruby
  rbenv install x.x.x
  rbenv global x.x.x
  rbenv rehash

install_gems updates itself, then installs bundler and rails.

  $ gem() { printf "gem %s\n" "$*"; }
  > install_gems
  gem update --system
  gem install bundler --no-document --pre
  gem install rails --no-document

install_hub uses curl to fetch a standalone hub into the direcotry 
specified as "local_bin".

  $ local_bin="./bin"
  > curl() { printf "curl %s\n" "$*"; touch ./bin/hub; }
  > install_hub
  curl http://hub.github.com/standalone -*o ./bin/hub (glob)

The installed hub should then be found at that location.

  $ which hub
  */base.t/bin/hub (glob)

configure_bundler will set the global job number to one less than the 
value in the "number_of_cores" variables.

  $ bundle() { printf "bundle %s\n" "$*"; }
  > number_of_cores=16
  > configure_bundler
  bundle config --global jobs 15

install_heroku_config installs the heroku-config plugin via git.

  $ heroku() { printf "heroku %s\n" "$*"; }
  > install_heroku_config
  heroku plugins:install git://github.com/ddollar/heroku-config.git
