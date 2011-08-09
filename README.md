Laptop
======

Laptop is a set of scripts to get your laptop set up as a development machine.

Mac OS X
--------

First, install [XCode](http://itunes.apple.com/us/app/xcode/id422352214?mt=12&ls=1). ($4.99, requires OS X 10.6.6 or higher)

Then, run this one-liner:

    bash < <(curl -s https://raw.github.com/thoughtbot/laptop/master/mac)

Ubuntu
------

First, install [Ubuntu](http://www.ubuntu.com/download).

Then, run this one-liner:

    bash < <(curl -s https://github.com/thoughtbot/laptop/raw/master/ubuntu)

If you're setting up Ubuntu for one of our workshops, we recommend you also install gEdit for your text editor.
You can [customize it with these instructions](http://blog.sudobits.com/2011/04/02/textmate-for-ubuntu-linux/).

What it sets up
---------------

* SSH public keys (for authenticating with services like Github and Heroku)
* Homebrew or apt-get (for managing operating system libraries)
* Ack (for finding things in files)
* Tmux (for saving project state and switching between projects)
* Postgres (for storing relational data)
* Redis (for storing key-value data)
* ImageMagick (for cropping and resizing images)
* RVM (for managing versions of the Ruby programming language)
* Ruby 1.9.2 stable (for writing general-purpose code)
* Bundler gem (for managing Ruby libraries)
* Rails gem (for writing web applications)
* Heroku gem (for interacting with the Heroku API)
* Taps gem (for pushing and pulling SQL databases between environments)
* Postgres gem (for making Ruby talk to SQL databases)

It should take about 30 minutes for everything to install, depending on your machine.
