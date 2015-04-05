#!/usr/bin/env ruby

LAPTOP_PATH = ENV.fetch("LAPTOP_PATH", "/opt/laptop")
LAPTOP_REPO = ENV.fetch("LAPTOP_REPO", "https://github.com/sharette/laptop.git")
LAPTOP_REPO_BRANCH = ENV.fetch("LAPTOP_REPO_BRANCH", "master")

module Tty extend self
  def blue; bold 34; end
  def green; bold 32; end
  def white; bold 39; end
  def red; underline 31; end
  def reset; escape 0; end
  def bold n; escape "1;#{n}" end
  def underline n; escape "4;#{n}" end
  def escape n; "\033[#{n}m" if STDOUT.tty? end
end

class Array
  def shell_s
    cp = dup
    first = cp.shift
    cp.map{ |arg| arg.gsub " ", "\\ " }.unshift(first) * " "
  end
end

def ohai *args
  puts "#{Tty.blue}==>#{Tty.white} #{args.shell_s}#{Tty.reset}"
end

def ohai_command *args
  puts "  #{Tty.green}> #{args.shell_s}#{Tty.reset}"
end

def warn warning
  puts "#{Tty.red}Warning#{Tty.reset}: #{warning.chomp}"
end

def system *args
  abort "Failed with #{$?} during: #{args.shell_s}" unless Kernel.system *args
end

def warnandexit message
  warn message
  exit
end

def sudo *args
  args = if args.length > 1
    args.unshift "/usr/bin/sudo"
  else
    "/usr/bin/sudo #{args.first}"
  end
  ohai_command *args
  system *args
end

def normaldo *args
  ohai_command *args
  system *args
end

def macos_version
  @macos_version ||= `/usr/bin/sw_vers -productVersion`.chomp[/10\.\d+/]
end

def has_command(name)
  `which #{name}`.length > 0
end

###########################################

abort "Don't run this as root!" if Process.uid == 0
abort <<-EOABORT unless `groups`.split.include? "admin"
This script requires the user #{ENV['USER']} to be an Administrator.
EOABORT

if macos_version != "10.10"
  abort "This script is only tested on OSX 10.10."
end

ohai "This script will setup:"
puts "  - FileVault if not already enabled"
puts "  - Command Line Tools if they are not installed"
puts "  - Ansible"
puts "  - All applications and settings from the playbook"
puts ""

if `fdesetup status`.include? "is Off"
  ohai "Enabling FileVault..."
  sudo "fdesetup enable -forcerestart"
  warnandexit "FileVault is enabled. Please restart the computer and relaunch this script."
else
  ohai "FileVault is enabled. Continuing..."
end

if File.exist? "/Library/Developer/CommandLineTools/usr/bin/clang"
  ohai "XCode Command Line Tools are installed. Continuing..."
else
  ohai "Installing the Command Line Tools (expect a GUI popup):"
  sudo "/usr/bin/xcode-select", "--install"
  warnandexit "Relaunch this script when the installation has completed."
end

if File.directory?(LAPTOP_PATH) && File.directory?("#{LAPTOP_PATH}/.git")
  ohai "Updating existing laptop installation..."
  Dir.chdir LAPTOP_PATH
  normaldo "git pull"
  normaldo "git checkout #{LAPTOP_REPO_BRANCH}"
else
  ohai "Setting up the laptop installation..."
  sudo "mkdir -p #{LAPTOP_PATH}"
  sudo "chown -R #{ENV["USER"]} #{LAPTOP_PATH}"
  normaldo "git clone -q #{LAPTOP_REPO} #{LAPTOP_PATH} -b #{LAPTOP_REPO_BRANCH}"
  Dir.chdir LAPTOP_PATH
end

Dir.chdir(LAPTOP_PATH)

if has_command "pip"
  ohai "pip is installed. Continuing..."
else
  ohai "Installing pip..."
  sudo "easy_install pip"
end

if has_command "ansible"
  ohai "Ansible is installed. Continuing..."
else
  ohai "Installing ansible..."
  sudo "pip install ansible"
end

ohai "Running ansible playbook"
normaldo "ansible-playbook -i hosts.ini site.yml --ask-sudo-pass"

ohai "Done!"
