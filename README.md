Laptop
======

Laptop is a script to set up an OS X laptop for web development.

Very few decisions are made for you, which means most steps require some
manual intervention. This is a GoodThing(tm)

Requirements
------------

We support:

* macOS El Capitan (10.11)
* macOS Sierra (10.12)

You should have the latest XCode tools installed through the App Store. You
also need to have accepted the license agreement for XCode by opening the app.

Install Homebrew
----------------

If you don't have Homebrew, you're going to need it.

```
curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
```

Follow the setup instructions, particularly setting the PATH.

* [Homebrew] for managing operating system libraries.

[Homebrew]: http://brew.sh/


Add Key Unix Tools with Homebrew
--------------------------------

The `Brewfile.unix` contains the bare minimum of Unix applications required
for building and running the Epion Health applications.

```
brew bundle --verbose --no-upgrade --file=Brewfile.unix
```

This files adds two taps to Homebrew and then installs any missing applications

Homebrew taps:

* homebrew/services - for managing services using `brew service [command] [app]`
* thoughtbot/formulae - for installing the `rcm` dotfile management tool from Thoughtbot

Brew-based Unix tools:

* [Exuberant Ctags] for indexing files for vim tab completion
* [Git] for version control
* [RCM] for managing company and personal dotfiles
* [The Silver Searcher] for finding things in files
* [Tmux] for saving project state and switching between projects

[Exuberant Ctags]: http://ctags.sourceforge.net/
[Git]: https://git-scm.com/
[RCM]: https://github.com/thoughtbot/rcm
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Tmux]: http://tmux.github.io/

GitHub tools:

* [Hub] for interacting with the GitHub API

[Hub]: http://hub.github.com/

Image tools:

* [ImageMagick 6] for cropping and resizing images

Testing tools:

* [Qt 5] for headless JavaScript testing via [Capybara Webkit]

[Qt 5]: http://qt-project.org/
[Capybara Webkit]: https://github.com/thoughtbot/capybara-webkit

Programming languages, package managers, and configuration:

* [Node.js] and [NPM], for running apps and installing JavaScript packages
* [Rbenv] for managing versions of Ruby
* [Ruby Build] for installing Rubies
* [Ruby] stable for writing general-purpose code

[ImageMagick]: http://www.imagemagick.org/
[Node.js]: http://nodejs.org/
[NPM]: https://www.npmjs.org/
[Rbenv]: https://github.com/sstephenson/rbenv
[Ruby Build]: https://github.com/sstephenson/ruby-build
[Ruby]: https://www.ruby-lang.org/en/

Databases:

* [Postgres] for storing relational data
* [Redis] for storing key-value data

[Postgres]: http://www.postgresql.org/
[Redis]: http://redis.io/

Add Key OSX Tools with Homebrew
--------------------------------

The `Brewfile.osx` file contains the bare minimum of OSX applications
required for building and running the Epion Health applications.

```
brew bundle --verbose --no-upgrade --file=Brewfile.osx
```

Key binary files:

* [Aptible Toolbelt] for interacting with the Aptible API
* [Keybase] for secure messaging and file transfer

[Aptible Toolbelt]: https://www.aptible.com/support/toolbelt/
[Keybase]: https://www.keybase.io/

It should take less than 15 minutes to install (depends on your machine).

Options
-------
Optionally, [install epionhealth/dotfiles][dotfiles].

[dotfiles]: https://github.com/epionhealth/dotfiles#install
