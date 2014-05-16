class Distro
  attr_reader :vagrantfile, :basename, :virtualbox_name, :rendered_box_name

  def initialize(vagrantfile)
    @vagrantfile = vagrantfile
    init_names
  end

  def link_vagrantfile
    vagrantfile_name = 'Vagrantfile'

    if File.exists?(vagrantfile_name)
      File.unlink(vagrantfile_name)
    end
    File.symlink(vagrantfile, vagrantfile_name)
  end

  def reset
    run_command('vagrant destroy --force')
    run_command('vagrant up')
  end

  def halt
    run_command('vagrant halt')
  end

  def prepare
    run_vagrant_ssh_command('sudo aptitude update')
    run_vagrant_ssh_command('sudo aptitude dist-upgrade -y')
  end

  def setup_laptop
    run_vagrant_ssh_command('echo vagrant | bash /vagrant/linux')
  end

  def active_shell
    run_vagrant_ssh_command_in_zsh_context('echo $SHELL')
  end

  def installed_ruby_version
    run_vagrant_ssh_command_in_zsh_context('ruby --version')
  end

  def generate_rails_app
    run_vagrant_ssh_command_in_zsh_context(
      'rm -Rf ~/test_app && cd ~ && rails new test_app'
    )
  end

  def scaffold_and_model_generation
    run_vagrant_ssh_command_in_zsh_context(
      'cd ~/test_app && rails g scaffold post title:string'
    )
  end

  def database_migration
    run_vagrant_ssh_command_in_zsh_context(
      'cd ~/test_app && rake db:create db:migrate db:test:prepare'
    )
  end

  def silver_searcher_test
    run_vagrant_ssh_command('command -v ag')
  end

  def package
    run_vagrant_ssh_command('rm -Rf ~/test_app')
    run_vagrant_ssh_command('sudo aptitude clean')

    run_command(
      %Q|vagrant package --base "#{virtualbox_name}" --output "#{rendered_box_name}"|
    )
  end

  def packaged?
    File.exists?(rendered_box_name)
  end

  private

  def init_names
    @basename = File.basename(vagrantfile).gsub('Vagrantfile.', '')
    @virtualbox_name = "laptop-#{basename}"
    @rendered_box_name = "#{basename}-with-laptop.box"
  end

  def run_vagrant_ssh_command(command)
    run_command("vagrant ssh -c '#{command}'")
  end

  def run_vagrant_ssh_command_in_zsh_context(command)
    run_command(%Q|vagrant ssh -c 'zsh -i -l -c "#{command}"'|)
  end

  def run_command(command)
   #  Cocaine::CommandLine.new(command, '', :logger => Logger.new(STDOUT)).run
    Cocaine::CommandLine.new(command, '').run
  end
end
