# CodeClan Laptop Setup

A script to set up a macOS laptop for development.

It can be run multiple times on the same machine safely. It installs, upgrades, or skips packages based on what is already installed on the machine.

## Requirements

We support:

* macOS El Capitan (10.11)
* macOS Sierra (10.12)

Older versions may work but aren't tested.

## Install

Download, review, then execute the script:

```sh
curl --remote-name https://raw.githubusercontent.com/codeclan/laptop/master/mac
```

Then run it:

```sh
sh mac 2>&1 | tee ~/laptop.log
```

Check the script was successful (occasionally may claim some application are missing that aren't) -

```sh
curl --remote-name https://raw.githubusercontent.com/codeclan/laptop/feature/install_success_check/laptop_install_test --output ~/laptop_install_test
sh ~/laptop_install_test
```

## What it sets up

### macOS tools:

* [Homebrew](http://brew.sh/) for managing operating system libraries.
* [Xcode](https://developer.apple.com/xcode/) which apparently you can't do anything on macOS without.

### Command line tools:

* [Git](https://git-scm.com/) for version control
* [Zsh](http://www.zsh.org/) as your shell
* [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) because we don't hate you

### Programming languages and configuration:

* [Ruby](https://www.ruby-lang.org/en/)
* [Rbenv](https://github.com/sstephenson/rbenv) for managing versions of Ruby
* [Bundler](http://bundler.io/) for managing Ruby libraries
* [Ruby Build](https://github.com/sstephenson/rbenv) for installing Rubies
* [Java](https://java.com/en/)
* [Node.js](http://nodejs.org/) for JavaScript back-end development, and
* [NPM](https://www.npmjs.org/) for installing JavaScript packages

### Databases:

* [PostgreSQL](http://www.postgresql.org/) for storing relational data
* [MongoDB](https://www.mongodb.com/) for storing non-relational data

### GUI Apps:

* [Google Chrome](https://www.google.com/chrome/) for web browsing and development
* [Atom](https://atom.io/) for text editing
* [Slack](https://slack.com) for team chat
* [IntelliJ IDEA CE](https://www.jetbrains.com/idea/) for Java development
* [Android Studio](https://developer.android.com/studio/index.html) for mobile development
* [MongoDB Compass](https://www.mongodb.com/products/compass) for accessing MongoDB databases from a GUI

### Fonts:
* Open Dyslexic for accessibility

Finally, we remap the `§` key on your Mac's keyboard to the `#` symbol, which can make commenting Ruby marginally less painful...

It should take less than 15 minutes to install (though this depends on your machine).

## About CodeClan

CodeClan offers a range of software development courses to help kick start your career in tech and deepen your digital expertise.

Transform your career at CodeClan by learning to code in our 16 week software development course. You don’t need to be a mathematician or have any previous technical experience. All you need is a willingness to learn, a passion for technology and to think like a problem solver.

Through our part-time learning options, you can add coding skills to your CV or build on your existing programming knowledge.

See [our website](https://codeclan.com) for more information.

![CodeClan](https://codeclan.com/wp-content/uploads/2016/03/favicon.png)
