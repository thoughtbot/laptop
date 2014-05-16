$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'cocaine'
require 'rspec'
require 'distro'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include LaptopHelper
end

def laptop_vagrantfiles
  Dir['./spec/vagrantfiles/Vagrantfile.*']
end
