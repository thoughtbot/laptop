# Laptop

This is a fork of [thoughtbot/laptop](<https://github.com/thoughtbot/laptop>) modified for my personal laptop setup.

Laptop is a script to set up a macOS laptop for web and mobile development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

## Requirements

We support:

* macOS Sequoia (15.x) on Apple Silicon and Intel
* macOS Sonoma (14.x) on Apple Silicon and Intel
* macOS Ventura (13.x) on Apple Silicon and Intel
* macOS Monterey (12.x) on Apple Silicon and Intel

Older versions may work but aren't regularly tested.
Bug reports for older versions are welcome.

## Install

Download the script:

```sh
curl --remote-name https://raw.githubusercontent.com/czeise/laptop/main/mac
```

Execute the downloaded script:

```sh
sh mac 2>&1 | tee ~/laptop.log
```

Optionally, review the log:

```sh
less ~/laptop.log
```

[Install dotfiles][dotfiles].

[dotfiles]: https://github.com/czeise/dotfiles#install

## Debugging

Your last Laptop run will be saved to `~/laptop.log`.
Read through it to see if you can debug the issue yourself.

## What it sets up

General tools and applications:

* [Homebrew] for managing operating system libraries.
* [1Password] for password management
* [Discord] for personal and tech community chat

[Homebrew]: http://brew.sh/
[1Password]: https://1password.com/
[Discord]: https://discord.com/

Unix tools:

* [Git] for version control
* [OpenSSL] for Transport Layer Security (TLS)
* [RCM] for managing dotfiles
* [The Silver Searcher] for finding things in files
* [Tmux] for saving project state and switching between projects
* [Zsh] as your shell

[Git]: https://git-scm.com/
[OpenSSL]: https://www.openssl.org/
[RCM]: https://github.com/thoughtbot/rcm
[The Silver Searcher]: https://github.com/ggreer/the_silver_searcher
[Tmux]: http://tmux.github.io/
[Zsh]: http://www.zsh.org/

<!-- GitHub tools:

* [GitHub CLI] for interacting with the GitHub API

[GitHub CLI]: https://cli.github.com/ -->

Image tools:

* [ImageMagick] for cropping and resizing images

Programming languages, package managers, and configuration:

* [asdf-vm] for managing programming language versions
* [Bundler] for managing Ruby libraries
* [Node.js] and [npm], for running apps and installing JavaScript packages
* [Ruby] stable for writing general-purpose code
* [Yarn] for managing JavaScript packages

[Bundler]: http://bundler.io/
[ImageMagick]: http://www.imagemagick.org/
[Node.js]: http://nodejs.org/
[npm]: https://www.npmjs.org/
[asdf-vm]: https://github.com/asdf-vm/asdf
[Ruby]: https://www.ruby-lang.org/en/
[Yarn]: https://yarnpkg.com/en/

Databases:

* [Postgres] for storing relational data
* [Redis] for storing key-value data

[Postgres]: http://www.postgresql.org/
[Redis]: http://redis.io/

General development tools and applications:

* [exa] as an `ls` replacement
* [overmind] for managing Procfile-based applications
* Terminal and Zsh tools (autocompletion, syntax highlighting, history search, etc.)
* [Firefox Developer Edition]
* [iterm2] for a better terminal experience
* [Visual Studio Code] editor

[exa]: https://the.exa.website/
[overmind]: https://github.com/DarthSim/overmind
[Firefox Developer Edition]: https://www.mozilla.org/en-US/firefox/developer/
[iterm2]: https://iterm2.com/
[Visual Studio Code]: https://code.visualstudio.com/

Personal development tools and applications (can be on TD laptop):

* [exercism] for programming exercises
* [flyctl] for deploying to Fly.io
* [utm] for running macOS in a virtual machine (and testing this script...)

[exercism]: https://exercism.io/
[flyctl]: https://fly.io/docs/flyctl/
[utm]: https://mac.getutm.app

Test Double Tools and applications:

* [Heroku CLI]
* Slack

[Heroku CLI]: https://devcenter.heroku.com/articles/heroku-cli

It should take less than 15 minutes to install (depends on your machine).

## Customize in `~/.laptop.local`

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

## Contributing

Thank you, [contributors]!

[contributors]: https://github.com/thoughtbot/laptop/graphs/contributors

By participating in this project,
you agree to abide by the thoughtbot [code of conduct].

[code of conduct]: https://thoughtbot.com/open-source-code-of-conduct

Edit the `mac` file.
Document in the `README.md` file.
Update the `CHANGELOG`.
Follow shell style guidelines by using [ShellCheck] and [Syntastic].

```sh
brew install shellcheck
```

[ShellCheck]: http://www.shellcheck.net/about.html
[Syntastic]: https://github.com/scrooloose/syntastic

### Testing your changes

Test your changes by running the script on a fresh install of macOS.
You can use the free and open source emulator [UTM].

Tip: Make a fresh virtual machine with the installation of macOS completed and
your user created and first launch complete. Then duplicate that machine to test
the script each time on a fresh install thats ready to go.

## License

Copyright © 2011 thoughtbot, inc.
It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE

<!-- START /templates/footer.md -->
## About thoughtbot

![thoughtbot](https://thoughtbot.com/thoughtbot-logo-for-readmes.svg)

This repo is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community].
We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github

<!-- END /templates/footer.md -->
