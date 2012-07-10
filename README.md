Laptop
======

Laptop is a script to set up your Max OS X laptop as a Rails development machine.

Install
-------

Before you run this script, you need compilers like GCC, LLVM, and Clang.

Get them via [OS X GCC Installer](https://github.com/kennethreitz/osx-gcc-installer/)
if you're on Snow Leopard (OS X 10.6) or
[Command Line Tools for XCode](https://developer.apple.com/downloads/index.action)
if you're on Lion (OS X 10.7).

Run the script:

    zsh < <(curl -s https://raw.github.com/thoughtbot/laptop/master/mac)

What it sets up
---------------

* SSH public key (for authenticating with services like Github and Heroku)
* Homebrew (for managing operating system libraries)
* Qt (used by Capybara Webkit for headless JavaScript testing)
* Ack (for finding things in files)
* Tmux (for saving project state and switching between projects)
* Postgres (for storing relational data)
* Redis (for storing key-value data)
* ImageMagick (for cropping and resizing images)
* RVM (for managing versions of the Ruby programming language)
* Ruby language (for writing general-purpose code)
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
