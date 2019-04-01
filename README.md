Laptop
======

Laptop is a script to set up an macOS laptop for web and mobile development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

Requirements
------------

We support:

* macOS Mavericks (10.9)
* macOS Yosemite (10.10)
* macOS El Capitan (10.11)
* macOS Sierra (10.12)
* macOS High Sierra (10.13)
* macOS Mojave (10.14)

Older versions may work but aren't regularly tested.
Bug reports for older versions are welcome.

Install
-------

Download the script:

```sh
curl --remote-name https://raw.githubusercontent.com/Unity-Technologies/laptop/master/mac
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
* [OpenSSL] for Transport Layer Security (TLS)

[Git]: https://git-scm.com/
[OpenSSL]: https://www.openssl.org/

# Google Cloud
* [Google-Cloud-Sdk] for interacting with GCP

[Google-Cloud-Sdk]: https://cloud.google.com/sdk/docs/quickstart-macos

Programming languages, package managers, and configuration:
* [Node.js] and [NPM], for running apps and installing JavaScript packages
* [Go], for running apps
* [Yarn] for managing JavaScript packages

[Node.js]: http://nodejs.org/
[Yarn]: https://yarnpkg.com/en/
[Go]: https://golang.org/

Contributing
------------

Edit the `mac` file.
Document in the `README.md` file.

License
-------

Laptop is © 2011-2018 thoughtbot, inc.
It is free software,
and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: LICENSE

