require 'spec_helper'

describe 'Laptop applied to a vagrant box' do
  after do
    run_command('vagrant halt')
  end

  laptop_vagrantfiles.each do |vagrantfile|
    it "should run laptop successfully for #{vagrantfile}" do
      distro = Distro.new(vagrantfile)
      distro.link_vagrantfile

      next if distro.packaged?

      puts "Testing #{distro.basename}"
      build_laptop_script

      distro.reset
      distro.prepare

      puts "Setting up laptop"

      expect { distro.setup_laptop }.not_to raise_error

      expect(distro.active_shell).to match /zsh/
      expect(distro.installed_ruby_version).to match latest_ruby_version

      puts "Generating rails app"
      expect { distro.generate_rails_app }.not_to raise_error
      expect { distro.scaffold_and_model_generation }.not_to raise_error
      expect { distro.database_migration }.not_to raise_error
      expect { distro.silver_searcher_test }.not_to raise_error

      puts "Packaging box for distribution"

      distro.package
    end
  end
end
