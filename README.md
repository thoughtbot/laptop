Laptop
======

Laptop is a set of scripts to get your Max OS X laptop set up as a Rails development machine.

Install
-------

First, install [GCC for OS X](https://github.com/kennethreitz/osx-gcc-installer). (requires OS X 10.6 or higher)

Then, run this one-liner:

    bash < <(curl -s https://raw.github.com/thoughtbot/laptop/master/mac)

What it sets up
---------------

* SSH public keys (for authenticating with services like Github and Heroku)
* Homebrew or apt-get (for managing operating system libraries)
* QT (used by Capybara Webkit for headless Javascript testing)
* Ack (for finding things in files)
* Tmux (for saving project state and switching between projects)
* Postgres (for storing relational data)
* Redis (for storing key-value data)
* ImageMagick (for cropping and resizing images)
* RVM (for managing versions of the Ruby programming language)
* Ruby 1.9.2 stable (for writing general-purpose code)
* Bundler gem (for managing Ruby libraries)
* Rails gem (for writing web applications)
* Heroku gem (for interacting with the Heroku API)
* Taps gem (for pushing and pulling SQL databases between environments)
* Postgres gem (for making Ruby talk to SQL databases)
* Foreman gem (for serving your Rails app locally)
* Git Remote Branch gem (for faster git branch creation and deletion)
* Heroku accounts plugin (for using multiple Heroku accounts like a client's account)
* Heroku config plugin (for pulling config variables locally to be used as ENV variables)

It should take about 30 minutes for everything to install, depending on your machine.
