Laptop
======

Laptop is a script to set up a Mac OS X or Linux laptop for Rails development.

Requirements
------------

### Mac OS X

Install a C compiler:

For Snow Leopard (10.6): use [OS X GCC
Installer](https://github.com/kennethreitz/osx-gcc-installer/).

For Lion (10.7) or Mountain Lion (10.8): use [Command Line Tools for
XCode](https://developer.apple.com/downloads/index.action).

For Mavericks (10.9): run `sudo xcodebuild -license` and follow the instructions
to accept the XCode agreement.  Then run `xcode-select --install` in your
terminal and then click "Install".

### Linux

We support:

* [13.10: Saucy Salamander](https://wiki.ubuntu.com/SaucySalamander/ReleaseNotes),
* [13.04: Raring Ringtail](https://wiki.ubuntu.com/RaringRingtail/ReleaseNotes),
* [12.10: Quantal Quetzal](https://wiki.ubuntu.com/QuantalQuetzal/ReleaseNotes), and
* [12.04 LTS: Precise Pangolin](https://wiki.ubuntu.com/PrecisePangolin/ReleaseNotes),
* Debian stable (currently [wheezy](http://www.debian.org/releases/stable/)).
* Debian testing (currently [jessie](http://www.debian.org/releases/testing/)).

Install
-------

### Mac OS X

Read, then run the script:

    bash <(curl -s https://raw.github.com/thoughtbot/laptop/master/mac)

### Linux

Read, then run the script:

    bash <(wget -qO- https://raw.github.com/thoughtbot/laptop/master/linux)

What it sets up
---------------

* Zsh as your shell
* Bundler gem for managing Ruby libraries
* Exuberant Ctags for indexing files for vim tab completion
* Foreman gem for serving Rails apps locally
* Heroku Config plugin for local `ENV` variables
* Heroku Toolbelt for interacting with the Heroku API
* Hub gem for interacting with the GitHub API
* Homebrew for managing operating system libraries (OS X only)
* ImageMagick for cropping and resizing images
* Postgres for storing relational data
* Qt for headless JavaScript testing via Capybara Webkit
* Rails gem for writing web applications
* Rbenv for managing versions of the Ruby programming language
* Redis for storing key-value data
* Ruby Build for installing Rubies
* Ruby stable for writing general-purpose code
* The Silver Searcher for finding things in files
* Tmux for saving project state and switching between projects
* Watch for periodically executing a program and displaying the output

It should take less than 15 minutes to install (depends on your machine).

Make your own customizations
----------------------------

Put your customizations in `~/.laptop.local`. For example, your
`~/.laptop.local` might look like this:

    #!/bin/sh

    brew tap phinze/homebrew-cask
    brew install brew-cask

    brew cask install dropbox
    brew cask install google-chrome
    brew cask install rdio

Credits
-------

![thoughtbot](http://thoughtbot.com/assets/tm/logo.png)

Laptop is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community).
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

Thank you, [contributors](https://github.com/thoughtbot/laptop/graphs/contributors)!

Contributing
------------

Please see [CONTRIBUTING.md](https://github.com/thoughtbot/laptop/blob/master/CONTRIBUTING.md).

License
-------

Laptop is © 2011-2014 thoughtbot, inc. It is free software, and may be
redistributed under the terms specified in the LICENSE file.
