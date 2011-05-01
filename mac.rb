puts "Installing RVM (Ruby Version Manager) ..."
  `bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )`
  `echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bash_profile`
  `source ~/.bash_profile`

puts "Installing Ruby 1.9 and making it the default Ruby ..."
  `rvm install 1.9.2-p180`
  `rvm use 1.9.2-p180 --default`

puts "Installing Bundler for managing Ruby libraries ..."
  `gem install bundler`

puts "Installing Rails to write and run web applications ..."
  `gem install rails`

puts "Installing the Heroku gem to interact with the http://heroku.com API ..."
  `gem install heroku`

puts "Installing the Taps gem to push and pull SQL databases between development, staging, and production environments"
  `gem install taps`

puts "Installing Homebrew, a great OS X package manager ..."
  `ruby -e "$(curl -fsSL https://gist.github.com/raw/323731/install_homebrew.rb)"`

puts "Installing git for version control ..."
  `brew git`

puts "Installing Postgres, a great open source relational database ..."
  `brew install postgres --no-python`

puts "Installing Redis, a key-value database ..."
  `brew install redis`

puts "Installing ImageMagick, good for cropping and re-sizing images ..."
  `brew install imagemagick`

puts "Setting up SSH keys. Press enter at each prompt ..."
  `ssh-keygen`

puts "Copying public key to clipboard. Paste it into your Github account ..."
  `cat ~/.ssh/id_rsa.pub | pbcopy`
  sleep 3
  `open https://github.com/account/ssh`

