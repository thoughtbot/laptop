# Testing

Laptop is tested by using it to provision a fresh VM. The process is lengthy
but scripted, and relies on Vagrant.

Currently, only the linux script is tested. See the dedicated section for
information about OSX testing.

## Prerequisites

1. [VirtualBox][]
2. [Vagrant][]

[VirtualBox]: https://www.virtualbox.org/
[Vagrant]: http://www.vagrantup.com/

## Running the tests

1. From the repository root, execute `./test/runner.sh`

## Details

For each file found at `./test/Vagrantfile.*`:

1. Vagrant creates and starts a VM as described by the Vagrantfile
2. The appropriate laptop script is run inside the VM
3. Some assertions are made against the VMs state
4. Vagrant stops and destroys the VM

The following are the assertions:

1. The VM was brought up successfully
2. The laptop script(s) ran successfully
3. The VM reports the correct `$SHELL`
4. The VM reports the correct ruby
5. A rails app can be created successfully
6. A scaffolded model can be created within that rails app
7. A default sqlite development and test database can be created and migrations can be run

You can test idempotency (allowing you to run the script multiple times in the
same environment) by exporting `KEEP_VM` before running `./test/runner.sh`
thusly:

  KEEP_VM=1 ./test/runner.sh

## OSX Testing

Adding additional linux tests via this framework should be easy: simply
add a new Vagrantfile under the test directory which uses a base box
with the desired distribution.

OSX will need to be handled specially:

1. The [VMware][] provider will have to be used
2. Building an OSX base box may or may not be easy
3. The resulting test can only be run on an OSX host

[VMware]: http://www.vmware.com/

## Notes on creating vagrant base boxes

The test script may fail when changing the vagrant user's shell to `zsh`. If
this happens, you need to configure PAM to allow a user to change their shell
without a password. Open '/etc/pam.d/chsh' and change the line:

  auth		sufficient	pam_rootok.so

to

  auth		sufficient	pam_permit.so

which will allow the vagrant user to change their shell without a password.
