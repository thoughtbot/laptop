#!/usr/bin/env ruby

LAPTOP_PATH = ENV.fetch("LAPTOP_PATH", "/opt/laptop")
LAPTOP_REPO = ENV.fetch("LAPTOP_REPO", "https://github.com/sharette/laptop.git")
LAPTOP_REPO_BRANCH = ENV.fetch("LAPTOP_REPO_BRANCH", "master")
DOTFILES_PATH = ENV.fetch("DOTFILES_PATH", "/opt/dotfiles")
DOTFILES_REPO = ENV.fetch("DOTFILES_REPO", "https://github.com/sharette/dotfiles.git")
DOTFILES_REPO_BRANCH = ENV.fetch("DOTFILES_REPO_BRANCH", "master")

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

def getc  # NOTE only tested on OS X
  system "/bin/stty raw -echo"
  if RUBY_VERSION >= '1.8.7'
    STDIN.getbyte
  else
    STDIN.getc
  end
ensure
  system "/bin/stty -raw echo"
end

def wait_for_user
  puts
  puts "Press ENTER to continue or any other key to abort"
  puts
  c = getc
  # we test for \r and \n because some stuff does \r instead
  abort unless c == 13 or c == 10
end

def macos_version
  @macos_version ||= `/usr/bin/sw_vers -productVersion`.chomp[/10\.\d+/]
end

def has_command(name)
  `which #{name}`.length > 0
end

if macos_version != "10.10"
  ohai "This script is only tested on OSX 10.10, proceed on your own risk."
  wait_for_user if macos_version < "10.8"
end

abort "Don't run this as root!" if Process.uid == 0
abort <<-EOABORT unless `groups`.split.include? "admin"
This script requires the user #{ENV['USER']} to be an Administrator.
EOABORT

ohai "This script will setup:"
puts "  - FileVault if not already enabled"
puts "  - Command Line Tools if they are not installed"
puts "  - Ansible"
puts "  - All applications and settings from the playbook"
puts ""

if macos_version > "10.8"
  unless File.exist? "/Library/Developer/CommandLineTools/usr/bin/clang"
    ohai "Installing the Command Line Tools (expect a GUI popup):"
    sudo "/usr/bin/xcode-select", "--install"
    puts "Press any key when the installation has completed."
    getc
  end
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

if File.directory?(DOTFILES_PATH) && File.directory?("#{DOTFILES_PATH}/.git")
  ohai "Updating existing dotfiles installation..."
  Dir.chdir DOTFILES_PATH
  normaldo "git pull"
  normaldo "git checkout #{DOTFILES_REPO_BRANCH}"
else
  ohai "Setting up the dotfiles installation..."
  sudo "mkdir -p #{DOTFILES_PATH}"
  sudo "chown -R #{ENV["USER"]} #{DOTFILES_PATH}"
  normaldo "git clone -q #{DOTFILES_REPO} #{DOTFILES_PATH} -b #{DOTFILES_REPO_BRANCH}"
  Dir.chdir DOTFILES_PATH
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
