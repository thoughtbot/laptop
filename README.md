Laptop
======

Laptop is a script to set up an OS X laptop for web development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

It is based on [thoughtbot/laptop](https://github.com/thoughtbot/laptop).

Mac Requirements
------------

* Make sure that you've installed XCode *before* running the laptop script. If you've not installed XCode, you will see the following error message:

> Can't install the software because it is not currently available from the Software Update server.

Base Install
-------

Clone the `laptop` repo, and then execute the script:

```sh
git clone git@github.com:policygenius/laptop.git
cd laptop
sh mac.sh 2>&1 | tee ~/laptop.log
```

In order to ensure consistent Docker environment, it should be downloaded manually from the Docker website.

[Mac Download](https://www.docker.com/docker-mac)
[Windows Download](https://www.docker.com/docker-windows)

kutil Install
--------------
```sh
pushd /usr/local/bin
curl --remote-name https://raw.githubusercontent.com/policygenius/laptop/master/kutil.rb
mv kutil{.rb,}
chmod +x kutil
popd
```


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

* Elasticsearch 5.6 issue

  Elasticsearch 5.6 is no longer served through homebrew - our install script should handle porting over a local version of Elasticsearch 5.6 and installing it from there. There is a hard dependency on Java 1.8, which this script should install as well. However, if you come across this error message when trying to install Elasticsearh 5.6

  ```
  $  brew install elasticsearch@5.6
  Error: elasticsearch@5.6: Unsupported special dependency :java
  ```

  and you are *certain* that you are on the right version (should look something like this)
  (if the install script has issues installing Java 1.8, `brew install openjdk@8` works)

  ```
  $  java -version
  openjdk version "1.8.0_282"
  OpenJDK Runtime Environment (build 1.8.0_282-bre_2021_01_20_16_37-b00)
  OpenJDK 64-Bit Server VM (build 25.282-b00, mixed mode)
  ```

  Comment/remove out the line in `elasticsearch@5.6.rb` that says `depends_on :java => "1.8"` and try reinstalling

Google Cloud Platform setup
---------------------------

* Log into GCP with the `gcloud` command
  * `gcloud auth login`
* Set up GCP application default credentials
  * `gcloud auth application-default login`
* Configure `gcloud` to use the sandbox project
  * `gcloud config set project pg-sandbox-165613`
* Configure `kubectl` to use the sandbox Kubernetes cluster
  * `gcloud container clusters get-credentials sandbox-v3 --zone us-central1-f --project pg-sandbox-165613`

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
