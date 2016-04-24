Laptop
======

Laptop is a script to set up an Ubuntu laptop for software development.

Requirements
------------

### Ubuntu

We support:

- [14.04: Trusty Tahr]

[14.04: Trusty Tahr]: https://wiki.ubuntu.com/TrustyTahr/ReleaseNotes

Install
-------

### Ubuntu

Read, then run the script:

    bash <(wget -qO- https://raw.githubusercontent.com/thoughtbot/laptop/master/linux) 2>&1 | tee ~/laptop.log

Debugging
---------

Your last Laptop run will be saved to `~/laptop.log`. Read through it to see if
you can debug the issue yourself. If not, copy the lines where the script
failed into a [new GitHub
Issue](https://github.com/ncronquist/laptop/issues/new) for us. Or, attach the
whole log file as an attachment.

What it sets up
---------------

- [Bundler] for managing Ruby libraries
- [Exuberant Ctags] for indexing files for vim tab completion
- [Foreman] for serving Rails apps locally
- [gh] for interacting with the GitHub API
- [Heroku Config] for local `ENV` variables
- [Heroku Toolbelt] for interacting with the Heroku API
- [ImageMagick] for cropping and resizing images
- [Node.js] and [NPM], for running apps and installing JavaScript packages
- [NVM] for managing versions of Node.js
- [Parity] for development, staging, and production parity
- [Postgres] for storing relational data
- [Qt] for headless JavaScript testing via Capybara Webkit
- [Rails] gem for writing web applications
- [Rbenv] for managing versions of Ruby
- [Redis] for storing key-value data
- [Ruby Build] for installing Rubies
- [Ruby] stable for writing general-purpose code
- [The Silver Searcher] for finding things in files
- [Tmux] for saving project state and switching between projects
- [Watch] for periodically executing a program and displaying the output
- [Zsh] as your shell

[Bundler]: http://bundler.io/
[Exuberant Ctags]: http://ctags.sourceforge.net/
[Foreman]: https://github.com/ddollar/foreman
[gh]: https://github.com/jingweno/gh
[Heroku Config]: https://github.com/ddollar/heroku-config
[Heroku Toolbelt]: https://toolbelt.heroku.com/
[ImageMagick]: http://www.imagemagick.org/
[Node.js]: http://nodejs.org/
[NPM]: https://www.npmjs.org/
[NVM]: https://github.com/creationix/nvm
[Parity]: https://github.com/croaky/parity
[Postgres]: http://www.postgresql.org/
[Qt]: http://qt-project.org/
[Rails]: http://rubyonrails.org/
[Rbenv]: https://github.com/sstephenson/rbenv
[Redis]: http://redis.io/
[Ruby Build]: https://github.com/sstephenson/ruby-build
[Ruby]: https://www.ruby-lang.org/en/
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Tmux]: http://tmux.sourceforge.net/
[Watch]: http://linux.die.net/man/1/watch
[Zsh]: http://www.zsh.org/

It should take less than 15 minutes to install (depends on your machine).

Laptop can be run multiple times on the same machine safely. It will upgrade
already installed packages and install and activate a new version of ruby (if
one is available).

Make your own customizations
----------------------------

Put your customizations in `~/.laptop.local`. For example, your
`~/.laptop.local` might look like this:

    #!/bin/sh

    brew tap caskroom/cask
    brew install brew-cask

    brew cask install dropbox
    brew cask install google-chrome
    brew cask install rdio

You should write your customizations such that they can be run safely more than
once. See the `linux` script for examples.

Credits
-------

![thoughtbot](http://thoughtbot.com/assets/tm/logo.png)

Laptop was created and funded by [thoughtbot, inc](http://thoughtbot.com/community).
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

While this is a fork of Thoughtbot's Laptop project, it is only related in origin.
Thoughtbot [dropped Linux support] in Oct. 2014, but I really like they way
they have organized their project so I am starting from their last Linux supported
commit.

[dropped Linux support]: https://github.com/thoughtbot/laptop/commit/91048f3f96f0d2d14c1106f746dd51c417a26e30

Contributing
------------

Please see [CONTRIBUTING.md](https://github.com/thoughtbot/laptop/blob/master/CONTRIBUTING.md).

License
-------

Laptop is free software, and may be redistributed under the terms specified in the LICENSE file.
