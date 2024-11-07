# Laptop

## Overview

Laptop is an automated setup script for configuring macOS or Linux laptops for backend and site reliability engineering work at One2N. We expect you to run the Linux or Mac scripts in your first week of joining One2N. Various useful tools (we are opinionated) are installed as part of these scripts.

## Key Features

- **Idempotent Execution:** Can be run multiple times safely on the same machine
- **Smart Installation:** Automatically handles package installation, upgrades, or skips based on existing state
- **Logging:** Maintains detailed logs for troubleshooting
- **Customizable:** Supports local customizations through `~/.laptop.local`

## Requirements

We support:

- macOS Monterey (12.3) on Apple Silicon and Intel

> Older versions may work but aren't regularly tested. Bug reports for older versions are welcome.

## Installation Guide

Download the script:

```sh
curl --remote-name https://raw.githubusercontent.com/one2nc/laptop/main/mac
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

Optionally, [install thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles#install).

## Debugging

Your last Laptop run will be saved to `~/laptop.log`.
Read through it to see if you can debug the issue yourself.

In case some package already exists (e.g. google-chrome), and the
script fails due to some error like

```
Error: It seems there is already an App at '/Applications/Google Chrome.app'.
```

use the `-f` (or `--force`) option and run that command again. In this case, run
`brew install --cask google-chrome --force`. This should reinstall Chrome properly.
Once done, you can run the main script again.

## What it sets up

macOS tools:

- [Homebrew](http://brew.sh/) for managing operating system libraries.

Version Control:

- [Git](https://git-scm.com/) for version control

Unix tools:

- [OpenSSL](https://www.openssl.org/) for Transport Layer Security (TLS)
- [Zsh](http://www.zsh.org/) as your shell

Alfred:

- [Alfred](https://www.alfredapp.com/) is an alternative to Spotlight.

Browsers:

- [Google Chrome](https://www.google.com/chrome/) is an cross-platform web browser developed by Google.
- [Firefox](https://www.mozilla.org/) is an extensible, free and open-source web browser developed by Mozilla corp.

Docker Desktop:

- [Docker Desktop](https://www.docker.com/products/docker-desktop) for containerization.

GitHub tools:

- [GitHub CLI](https://cli.github.com/) for interacting with the GitHub API

Google Drive:

- [Google Drive](https://drive.google.com) backup to Google Photos, and access all of your content directly from your Mac.

IDEs:

- [Intellij community edition](https://www.jetbrains.com/idea/download/#section=mac) for JVM languages designed to maximize developer productivity.
- [Sublime text](https://www.sublimetext.com/) is Sublime Text is a shareware cross-platform source code editor.
- [Visual studio code](https://code.visualstudio.com/) a free-editor that helps the programmer write code, helps in debugging and corrects the code using the intelli-sense method.
- [Vim](https://www.vim.org/) Vim is a highly configurable text editor built to make creating and changing any kind of text very efficient.

Iterm2:

- [Iterm2](https://iterm2.com/) is a terminal emulator for MacOS.

Lastpass:

- [lastpass](https://lastpass.com) for password management.

Libreoffice:

- [Libreoffice](https://www.libreoffice.org/) is a free and open-source office productivity software suite.

Maccy:

- [Maccy](https://maccy.app/) for Clipboard management.

Markdown:

- [Macdown](https://macdown.uranusjr.com/) is an open source Markdown editor for MacOS.
- [Obsidian](https://obsidian.md/) is a powerful knowledge base on top of a local folder of plain text Markdown files.

Numi:

- [Numi](https://numi.app/) is a calculator that magically combines calculations with text, and allows you to freely share calculations with others.

Notion:

- [Notion](https://notion.so) is a project management and note-taking software.

Postman:

- [Postman](https://www.postman.com/) for testing API.

Rectangle:

- [Rectangle](https://rectangleapp.com/) Move and resize windows in macOS using keyboard shortcuts or snap areas.

Scroll Reverser:

- [Scroll Reverser](https://pilotmoon.com/scrollreverser/) is a free Mac app that reverses the direction of scrolling, with independent settings for trackpads and mice.

Slack:

- [Slack](https://slack.com) is a messaging program designed specifically for the office.

Table Plus:

- [Table Plus](https://tableplus.com/) for database management.

WhatsApp:

- [WhatsApp](https://www.whatsapp.com/) for messaging.

Zoom:

- [Zoom](https://zoom.us) is a video conferencing platform.

It should take less than 15 minutes to install (depends on your machine).

## Customization

Create a `~/.laptop.local` file to add custom configurations:

Your `~/.laptop.local` is run at the end of the Laptop script.
Put your customizations there.
For example:

```sh
#!/bin/sh

brew bundle --file=- <<EOF
# Add additional packages
brew "go"
brew "ngrok"
brew "watch"

# Add custom casks
brew "Caskroom/cask/dockertoolbox"

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

# Custom cleanup
fancy_echo "Cleaning up old Homebrew formulae ..."
brew cleanup
brew cask cleanup

# Update dotfiles if present
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

Edit the `mac` file.
Document in the `README.md` file.
Follow shell style guidelines by using [ShellCheck](http://www.shellcheck.net/about.html) and [Syntastic](https://github.com/scrooloose/syntastic).

```sh
brew install shellcheck
```

### Testing your changes

Test your changes by running the script on a fresh install of macOS.
You can use the free and open source emulator [UTM](https://mac.getutm.app).

Tip: Make a fresh virtual machine with the installation of macOS completed and
your user created and first launch complete. Then duplicate that machine to test
the script each time on a fresh install thats ready to go.

Thank you, [contributors](https://github.com/thoughtbot/laptop/graphs/contributors)!

By participating in this project,
you agree to abide by the thoughtbot [code of conduct](https://thoughtbot.com/open-source-code-of-conduct).

## License

Laptop is © 2011-2022 thoughtbot, inc.
It is free software,
and may be redistributed under the terms specified in the [LICENSE](LICENSE) file.

## About thoughtbot

![thoughtbot](https://thoughtbot.com/brand_assets/93:44.svg)

Laptop is maintained and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We are passionate about open source software.
See [our other projects](https://thoughtbot.com/community?utm_source=github).
We are [available for hire](https://thoughtbot.com?utm_source=github).
