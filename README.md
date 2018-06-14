# Laptop

Laptop is a script to set up a Mac for web development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

## Requirements

We support:

- macOS Sierra (10.12)
- OS X El Capitan (10.11)
- OS X Yosemite (10.10)

Older versions may work but aren't regularly tested. Bug reports for older
versions are welcome.

## Install

Download, review, then execute the script:

```sh
git clone git@github.com:sparkbox/laptop.git
less mac
sh mac 2>&1 | tee ~/laptop.log
```

Optionally, [install thoughtbot/dotfiles][dotfiles].

[dotfiles]: https://github.com/thoughtbot/dotfiles#install

## Debugging

Your last Laptop run will be saved to `~/laptop.log`.
Read through it to see if you can debug the issue yourself.
If not, copy the lines where the script failed into a
[new GitHub Issue](https://github.com/thoughtbot/laptop/issues/new) for us.
Or, attach the whole log file as an attachment.

## What it sets up

- [Bundler] for managing Ruby libraries
- [Exuberant Ctags] for indexing files for vim tab completion
- [Foreman] for managing web processes
- [hub] for interacting with the GitHub API
- [Heroku Toolbelt] for interacting with the Heroku API
- [Homebrew] for managing operating system libraries
- [ImageMagick] for cropping and resizing images
- [Node.js] and [NPM], for running apps and installing JavaScript packages
- [Postgres] for storing relational data
- [Qt] for headless JavaScript testing via Capybara Webkit
- [Rbenv] for managing versions of Ruby
- [RCM] for managing company and personal dotfiles
- [Redis] for storing key-value data
- [Ruby Build] for installing Rubies
- [Ruby] stable for writing general-purpose code
- [The Silver Searcher] for finding things in files
- [Tmux] for saving project state and switching between projects
- [Zsh] as your shell

[bundler]: http://bundler.io/
[exuberant ctags]: http://ctags.sourceforge.net/
[firefox]: https://www.mozilla.org/en-US/firefox/
[foreman]: https://github.com/ddollar/foreman
[google chrome]: https://www.google.com/chrome/
[hub]: http://hub.github.com/
[heroku toolbelt]: https://toolbelt.heroku.com/
[homebrew]: http://brew.sh/
[imagemagick]: http://www.imagemagick.org/
[node.js]: http://nodejs.org/
[npm]: https://www.npmjs.org/
[postgres]: http://www.postgresql.org/
[qt]: http://qt-project.org/
[rvm]: https://rvm.io
[rcm]: https://github.com/thoughtbot/rcm
[redis]: http://redis.io/
[ruby]: https://www.ruby-lang.org/en/
[the silver searcher]: https://github.com/ggreer/the_silver_searcher
[tmux]: http://tmux.sourceforge.net/
[vim]: https://github.com/vim/vim/
[zsh]: http://www.zsh.org/

It should take less than 15 minutes to install (depends on your machine).

## Customize in `~/.laptop.local`

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

## Contributing

Edit the `mac` file.
Document in the `README.md` file.
Follow shell style guidelines by using [ShellCheck] and [Syntastic].

```sh
brew install shellcheck
```

[shellcheck]: http://www.shellcheck.net/about.html
[syntastic]: https://github.com/scrooloose/syntastic

Thank you, [contributors]!

[contributors]: https://github.com/thoughtbot/laptop/graphs/contributors

By participating in this project,
you agree to abide by the thoughtbot [code of conduct].

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

## License

Laptop is © 2011-2015 thoughtbot, inc.
It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[license]: LICENSE

## About thoughtbot

![thoughtbot](https://thoughtbot.com/logo.png)

Laptop is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We are passionate about open source software.
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com?utm_source=github
