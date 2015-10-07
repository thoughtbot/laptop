Laptop
======

Laptop is a script to set up an OS X laptop for web development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

Requirements
------------

We support:

* [OS X Mavericks (10.9)](https://itunes.apple.com/us/app/os-x-mavericks/id675248567)
* [OS X Yosemite (10.10)](https://www.apple.com/osx/)

Older versions may work but aren't regularly tested. Bug reports for older
versions are welcome.

Install
-------

Download, review, then execute the script:

```sh
curl --remote-name https://raw.githubusercontent.com/epionhealth/laptop/master/mac
less mac
bash mac 2>&1 | tee ~/laptop.log
```

Optionally, [install thoughtbot/dotfiles][dotfiles].

[dotfiles]: https://github.com/epionhealth/dotfiles#install

Debugging
---------

Your last Laptop run will be saved to `~/laptop.log`.
Read through it to see if you can debug the issue yourself.
If not, copy the lines where the script failed into a
[new GitHub Issue](https://github.com/thoughtbot/laptop/issues/new) for us.
Or, attach the whole log file as an attachment.

What dev tools it sets up
---------------

* [Bundler] for managing Ruby libraries
* [Exuberant Ctags] for indexing files for vim tab completion
* [Foreman] for managing web processes
* [hub] for interacting with the GitHub API
* [Heroku Toolbelt] for interacting with the Heroku API
* [Homebrew] for managing operating system libraries
* [ImageMagick] for cropping and resizing images
* [Node.js] and [NPM], for running apps and installing JavaScript packages
* [Postgres] for storing relational data
* [Qt] for headless JavaScript testing via Capybara Webkit
* [RVM] for managing versions of Ruby
* [RCM] for managing company and personal dotfiles
* [Redis] for storing key-value data
* [Ruby Build] for installing Rubies
* [Ruby] stable for writing general-purpose code
* [The Silver Searcher] for finding things in files
* [Tmux] for saving project state and switching between projects
* [Zsh] as your shell

[Bundler]: http://bundler.io/
[Exuberant Ctags]: http://ctags.sourceforge.net/
[Foreman]: https://github.com/ddollar/foreman
[hub]: http://hub.github.com/
[Heroku Toolbelt]: https://toolbelt.heroku.com/
[Homebrew]: http://brew.sh/
[ImageMagick]: http://www.imagemagick.org/
[Node.js]: http://nodejs.org/
[NPM]: https://www.npmjs.org/
[Postgres]: http://www.postgresql.org/
[Qt]: http://qt-project.org/
[RVM]: https://rvm.io/
[RCM]: https://github.com/thoughtbot/rcm
[Redis]: http://redis.io/
[Ruby Build]: https://github.com/sstephenson/ruby-build
[Ruby]: https://www.ruby-lang.org/en/
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Tmux]: http://tmux.sourceforge.net/
[Zsh]: http://www.zsh.org/

What binaries it installs
------------------

* [Google Chrome] for web browsing
* [Alfred] for a more productive task bar
* [Caffeine] to keep your mac from sleeping
* [Google Drive] for sharing documents
* [Day-O] the menu bar calendar that OS X should have had
* [F.lux] to adapt your screen hue to the time of day
* [ShiftIt] for managing windows

[Google Chrome]: https://www.google.com/chrome/browser/desktop/
[Alfred]: https://www.alfredapp.com/
[Caffeine]: http://lightheadsw.com/caffeine/
[Google Drive]: https://www.google.com/drive/
[Day-O]: http://www.shauninman.com/archive/2011/10/20/day_o_mac_menu_bar_clock
[F.lux]: https://justgetflux.com/
[ShiftIt]: https://github.com/onsi/ShiftIt

Customize in `~/.laptop.local`
------------------------------

Your `~/.laptop.local` is run at the end of the Laptop script.
Put your customizations there.
For example:

```sh
#!/bin/sh

brew_tap 'caskroom/cask'
brew_install_or_upgrade 'brew-cask'

brew cask install dropbox
brew cask install google-chrome
brew cask install rdio

gem_install_or_update 'parity'

brew_install_or_upgrade 'tree'
brew_install_or_upgrade 'watch'
```

Write your customizations such that they can be run safely more than once.
See the `mac` script for examples.

Laptop functions such as `fancy_echo`,
`brew_install_or_upgrade`, and
`gem_install_or_update`
can be used in your `~/.laptop.local`.

See the [wiki](https://github.com/thoughtbot/laptop/wiki)
for more customization examples.

Contributing
------------

Edit the `mac` file.
Document in the `README.md` file.
Follow shell style guidelines by using [ShellCheck] and [Syntastic].

```sh
brew install shellcheck
```

[ShellCheck]: http://www.shellcheck.net/about.html
[Syntastic]: https://github.com/scrooloose/syntastic

Thank you, [contributors]!

[contributors]: https://github.com/thoughtbot/laptop/graphs/contributors

By participating in this project,
you agree to abide by the thoughtbot [code of conduct].

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

License
-------

Laptop is © 2011-2015 thoughtbot, inc.
It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE

About thoughtbot
----------------

![thoughtbot](https://thoughtbot.com/logo.png)

Laptop is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We are passionate about open source software.
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com?utm_source=github
