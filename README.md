Laptop
======

Laptop is a script to set up an OS X laptop for web development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

It is based on [thoughtbot/laptop](https://github.com/thoughtbot/laptop).

Requirements
------------

We support:

* [OS X Yosemite (10.10)](https://www.apple.com/osx/)

Older versions may work but aren't regularly tested. Bug reports for older
versions are welcome.

* [Xcode]:(https://itunes.apple.com/us/app/xcode/id497799835) must be installed.

Install
-------

Download, review, then execute the script:

```sh
curl --remote-name https://raw.githubusercontent.com/policygenius/laptop/master/mac.sh
less mac.sh
sh mac.sh 2>&1 | tee ~/laptop.log
```

In order to ensure consistent Docker environment, it should be downloaded manually from the Docker website.

[Mac Download](https://www.docker.com/docker-mac)
[Windows Download](https://www.docker.com/docker-windows)

**For OS X Sierra + (10.12+) and XCode 8:**

With Xcode 8.0, when trying to compile the gem you may get the error Project ERROR: Xcode not set up properly. You may need to confirm the license agreement by running /usr/bin/xcodebuild. — even after confirming the license agreement. This is an upstream Qt bug that can be worked around by following these instructions:

1. Find the Qt install folder
2. Open [Qt_install_folder]/[Qt_version](/clang_64 || )/mkspecs/features/mac/default_pre.prf in a text editor

   If you can't find the file, look for it by searching all files for the following line by running grep -rn /usr/bin/xcrun . in the [Qt_install_folder] or [Qt_version] director

   For this laptop script and Qt 5.5.1, you edit the file directly in VIM via the command line:

   `vim /usr/local/Cellar/qt@5.5/5.5.1/mkspecs/features/mac/default_pre.prf`

3. Find the line with this text (for me it was line 15):

   `isEmpty($$list($$system("/usr/bin/xcrun -find xcrun 2>/dev/null"))): \`

4. Replace line with:

   `isEmpty($$list($$system("/usr/bin/xcrun -find xcodebuild 2>/dev/null"))): \`

5. Save & re-install the gem

_For further reading: https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#macos-sierra-1012_


Debugging
---------

Your last Laptop run will be saved to `~/laptop.log`. Read through it to see if
you can debug the issue yourself. If not, copy the lines where the script
failed into a [new GitHub
Issue](https://github.com/policygenius/laptop/issues/new) for us. Or, attach the
whole log file as an attachment.

PolicyGenius specific tips
--------------------------
* PG repo
  * If after installing all dependancies you are getting `Invalid CSS` error in the browser, it might be Node version. Check that you are using `v0.12`.
* Elasticsearch 5.5.2 issue
  After running the laptop script, Elasticsearch will be installed as version 5.5.2, which is the current stable version. You may encounter issues when seeding the `policygenius` application related to this Elasticsearch version. If so, you will need to uninstall Elasticsearch and reinstall with version 2.4.

  * Follow the commands at [this gist]( https://gist.github.com/jkubacki/e2dd904bd648b0bd4554 ) for removing Elasticsearch and uninstalling through Homebrew.
  * Run `ps aux | grep elasticsearch` to ensure that the Elasticsearch process started in the laptop script is not still running. If it is, kill the process with `kill -9 $PID` where `$PID` is the ID for the Elasticsearch process.
  * Then, run `brew search elasticsearch` to see a current list of Elasticsearch versions and install `elasticsearch@2.4` through Homebrew with `brew install elasticsearch@2.4`.
  * Once installed, run `brew services start elasticsearch@2.4` and you should be able to seed the database (don't forget to drop, create and migrate if necessary!) properly.

Google Cloud Platform setup
---------------------------

* Log into GCP with the `gcloud` command
  * `gcloud auth login`
* Configure `gcloud` to use the sandbox project
  * `gcloud config set project pg-sandbox-165613`
* Configure `kubectl` to use the sandbox Kubernetes cluster
  * `gcloud containers clusters get-credentials sandbox-v3 --zone us-central1-f --project pg-sandbox-165613`

What it sets up
---------------

* [Bundler] for managing Ruby libraries
* [Exuberant Ctags] for indexing files for vim tab completion
* [Foreman] for managing web processes
* [gh] for interacting with the GitHub API
* [aptible] for HIPAA-compliant deploys
* [Homebrew] and [Homebrew Cask] for managing operating system libraries
* [ImageMagick] for cropping and resizing images
* [Node.js] and [NPM], for running apps and installing JavaScript packages
* [Postgres] for storing relational data
* [Qt] for headless JavaScript testing via Capybara Webkit
* [Rbenv] for managing versions of Ruby
* [Redis] for storing key-value data
* [Ruby Build] for installing Rubies
* [Ruby] stable for writing general-purpose code
* [The Silver Searcher] for finding things in files
* [Tmux] for saving project state and switching between projects
* [Zsh] as your shell and [Oh My ZSH!] as a base config
  - Includes a [ZSH Syntax Highlighting]
  - Includes [Z], a script that makes navigating in the terminal much faster.
* [Docker] for prod-like development environments
* [MacVim] for writing code and [pivotalcommon/vim-config] as a base config
* [iTerm2] for your terminal
* [Slack] for team communication
* [Screenhero] for remote pairing
* [Sourcetree] because sometime you just want a GUI
* [ShiftIt] for window management
* [Google Chrome] and [Firefox] browsers

[Bundler]: http://bundler.io/
[Exuberant Ctags]: http://ctags.sourceforge.net/
[Foreman]: https://github.com/ddollar/foreman
[gh]: https://github.com/jingweno/gh
[aptible]: https://github.com/aptible/aptible-cli
[Homebrew]: http://brew.sh/
[Homebrew Cask]: http://caskroom.io/
[ImageMagick]: http://www.imagemagick.org/
[Node.js]: http://nodejs.org/
[NPM]: https://www.npmjs.org/
[Postgres]: http://www.postgresql.org/
[Qt]: http://qt-project.org/
[Rbenv]: https://github.com/sstephenson/rbenv
[Redis]: http://redis.io/
[Ruby Build]: https://github.com/sstephenson/ruby-build
[Ruby]: https://www.ruby-lang.org/en/
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Tmux]: http://tmux.sourceforge.net/
[Zsh]: http://www.zsh.org/
[Oh My ZSH!]: http://ohmyz.sh/
[ZSH Syntax Highlighting]: https://github.com/zsh-users/zsh-syntax-highlighting
[Z]: https://github.com/rupa/z
[Docker]: https://www.docker.com/
[MacVim]: https://github.com/b4winckler/macvim
[pivotalcommon/vim-config]: https://github.com/pivotalcommon/vim-config
[iTerm2]: http://iterm2.com/
[Slack]: https://slack.com/
[Screenhero]: https://screenhero.com/
[SourceTree]: http://www.sourcetreeapp.com/
[ShiftIt]: https://github.com/onsi/ShiftIt
[Google Chrome]: https://www.google.com/chrome
[Firefox]: https://www.mozilla.org/firefox

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
See the `mac.sh` script for examples.

Laptop functions such as `fancy_echo`,
`brew_install_or_upgrade`,
`cask_install_or_upgrade`,
`gem_install_or_update`, and
`append_to_zshrc`
can be used in your `~/.laptop.local`.
