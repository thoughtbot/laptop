Contributing
============

Laptop is broken into separate script files under `./src`:

1. base.sh - functions and variables shareable across Linux and OSX.
2. mac.sh - functions and variables specific to OSX.
3. linux.sh - functions and variables specific to Linux.
4. run.sh - execution of functions to complete the install.

Three of these files are concatenated into `./linux` or `./mac` via the 
`./bin/build` script. As may be obvious, building `./linux` will build 
with `linux.sh` and without `mac.sh` and building `./mac` will do the 
opposite. You may pass an argument of `linux` or `mac` to `./bin/build` 
to only build a single script. Passing no arguments builds both.

To extend / modify laptop:

1. Make a change in the appropriate place under `./src`.
2. Commit your actual change.
3. Run `./bin/build`.
4. Confirm the scripts were built as expected and commit this 
   compilation step separately.
