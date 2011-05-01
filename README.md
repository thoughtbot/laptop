Laptop
======

Laptop is a set of scripts to get your laptop set up as a development machine.

Mac OS X
--------

First, install [XCode](http://developer.apple.com/technologies/tools/xcode.html).

Then, run this one-liner:

    bash < <( curl -s https://github.com/thoughtbot/laptop/raw/master/mac )

Ubuntu
------

First, install [Ubuntu](http://www.ubuntu.com/download).

Then, run this one-liner:

    bash < <( curl -s https://github.com/thoughtbot/laptop/raw/master/ubuntu )

What it sets up
---------------

* package manager (Homebrew on OS X, apt-get on Ubuntu)
* git
* ack
* Postgres
* Redis
* ImageMagick
* RVM (Ruby Version Manager)
* Ruby 1.9.2-p180
* Gems: bundler, rails, heroku, taps, sqlite3 pg
* ssh public keys
