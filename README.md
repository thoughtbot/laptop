Laptop
======

Laptop is a script to set up a macOS laptop for web and mobile development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages based on what is already installed on the machine.

*NOTE*: Please take a moment to read *and customize* this script before running. The packages below are helpful suggestions, not a prescriptive list.

Requirements
------------

We support:

* macOS Mojave (10.14)
* macOS Catalina (10.15)

Older versions may work but haven't been tested recently.

Install
-------

Download the script:

```sh
curl --remote-name https://raw.githubusercontent.com/CoProcure/laptop/master/mac
```

Review the script (avoid running scripts you haven't read!):

```sh
less mac
```

Execute the downloaded script:

```sh
sh mac 2>&1 | tee ~/laptop.log
```

Optionally, review the log:

```sh
less ~/laptop.log
```

Debugging
---------

Your last Laptop run will be saved to `~/laptop.log`.
Read through it to see if you can debug the issue yourself.
If not, copy the lines where the script failed into a
[new GitHub Issue](https://github.com/thoughtbot/laptop/issues/new) for us.
Or, attach the whole log file as an attachment.

What it sets up
---------------

macOS tools:

* [Homebrew] for managing operating system libraries.

[Homebrew]: http://brew.sh/

Unix tools:

* [Git] for version control
* [htop] for viewing process information in the CLI
* [OpenSSL] for Transport Layer Security (TLS)
* [The Silver Searcher] for finding things in files
* [vim] as a handy in-terminal editor for rainy days
* [Zsh] as your shell
* [Oh My Zsh] framework for Zsh

[Git]: https://git-scm.com/
[htop]: https://hisham.hm/htop/
[OpenSSL]: https://www.openssl.org/
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[vim]: https://www.vim.org/
[Zsh]: http://www.zsh.org/

Development tools:

* [AWS CLI] for interacting with the Amazon API
* [Heroku CLI] for interacting with the Heroku API
* [Sentry CLI] for interacting with the Sentry API

[AWS CLI]: https://aws.amazon.com/cli/
[Heroku CLI]: https://devcenter.heroku.com/articles/heroku-cli
[Sentry CLI]: https://github.com/getsentry/sentry-cli
[Oh My Zsh]: https://ohmyz.sh/

Programming languages, package managers, and configuration:

* [Node.js] and [npm], for running apps and installing JavaScript packages. This installer uses `nvm` to manage Node versions.
* [Ruby] stable for writing general-purpose code. This installer uses `rbenv` to manage Ruby versions.
* [rbenv] for managing your Ruby environment
* [Node.js] and [npm], for running apps and installing JavaScript packages
* [nvm] for managing versions of node.js
* [Ruby] stable for writing general-purpose code

[Node.js]: http://nodejs.org/
[npm]: https://www.npmjs.org/
[nvm]: https://github.com/nvm-sh/nvm
[Ruby]: https://www.ruby-lang.org/en/
[rbenv]: https://github.com/rbenv/rbenv


Databases:

* [Postgres] for storing relational data
* [Redis] for storing key-value data

[Postgres]: http://www.postgresql.org/
[Redis]: http://redis.io/

Applications:

* [Google Chrome] as a browser option, and for testing
* [Firefox] as a browser option, and for testing
* [Slack] for team communication
* [iTerm2] for an improved terminal experience
* [Sublime Text] as a text editor option
* [Sublime Merge] as a merge/diff tool and as a companion to Sublime Text
* [Visual Studio Code] as a text editor option
* [Insomnia] for a convenient UI to experiment with API endpoints
* [Flycut] to expand the depth/history of your clipboard
* [BitWarden] to store passwords/secrets and share them with teammates
* [Caffeine] to keep your computer from falling asleep when you don't want it to
* [Docker] for managing portable VMs
* [Zoom] for videoconferencing
* [TablePlus] for connecting to local and remote relational DBs

[Google Chrome]: https://www.google.com/chrome/
[Firefox]: https://www.mozilla.org/en-US/firefox/new/
[Slack]: https://slack.com/
[iTerm2]: https://www.iterm2.com/
[Sublime Text]: https://www.sublimetext.com/
[Sublime Merge]: https://www.sublimemerge.com/
[Visual Studio Code]: https://code.visualstudio.com/
[Insomnia]: https://insomnia.rest/
[Flycut]: https://github.com/TermiT/flycut
[BitWarden]: https://bitwarden.com/
[Caffeine]: http://lightheadsw.com/caffeine/
[Docker]: https://www.docker.com/
[Zoom]: https://zoom.us/
[TablePlus]: https://tableplus.com/

Customize in `~/.laptop.local`
------------------------------

Your `~/.laptop.local` is run at the end of the Laptop script.
Put your customizations there.
For example:

```sh
#!/bin/sh

brew bundle --file=- <<EOF
brew "Caskroom/cask/dockertoolbox"
brew "go"
brew "ngrok"
brew "watch"
EOF

default_docker_machine() {
  docker-machine ls | grep -Fq "default"
}

if ! default_docker_machine; then
  docker-machine create --driver virtualbox default
fi

default_docker_machine_running() {
  default_docker_machine | grep -Fq "Running"
}

if ! default_docker_machine_running; then
  docker-machine start default
fi

fancy_echo "Cleaning up old Homebrew formulae ..."
brew cleanup
brew cask cleanup

if [ -r "$HOME/.rcrc" ]; then
  fancy_echo "Updating dotfiles ..."
  rcup
fi
```

Write your customizations such that they can be run safely more than once.
See the `mac` script for examples.

Laptop functions such as `fancy_echo` and
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

Fork Information
----------------

This repo is a fork of one originally put together by Thoughtbot, and has been customized to meet some of the needs of CoProcure engineers while retaining some opinionation about handy tools and common configurations.

The original Thoughtbot project has some features that have been excluded in this fork, and that project may also continue to recieve updates that are of interest to some developers. For more info, visit the original Thoughtbot repo at https://github.com/thoughtbot/laptop


License
-------

Laptop is © 2011-2020 thoughtbot, inc.
It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE

About thoughtbot
----------------

![thoughtbot](https://thoughtbot.com/brand_assets/93:44.svg)

Laptop is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We are passionate about open source software.
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com?utm_source=github
