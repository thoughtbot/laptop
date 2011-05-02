echo "Installing Ruby 1.9 and making it the default Ruby ..."
  rvm install 1.9.2-p180
  rvm use 1.9.2-p180 --default

echo "Installing Bundler for managing Ruby libraries ..."
  gem install bundler --no-rdoc --no-ri

echo "Installing Rails to write and run web applications ..."
  gem install rails --no-rdoc --no-ri

echo "Installing the Heroku gem to interact with the http://heroku.com API ..."
  gem install heroku --no-rdoc --no-ri

echo "Installing the Taps gem to push and pull SQL databases between development, staging, and production environments ..."
  gem install taps --no-rdoc --no-ri

echo "Installing Ruby gems to talk to the databases ..."
  gem install sqlite3 pg --no-rdoc --no-ri
