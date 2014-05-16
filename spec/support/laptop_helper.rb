require 'logger'
require 'net/http'

module LaptopHelper
  def run_command(command)
   #  Cocaine::CommandLine.new(command, '', :logger => Logger.new(STDOUT)).run
    Cocaine::CommandLine.new(command, '').run
  end

  def build_laptop_script
    run_command('./bin/build.sh')
  end

  def latest_ruby_version
    Net::HTTP.get(URI("http://ruby.thoughtbot.com/latest")).chomp
  end
end
