#!/usr/bin/env ruby

def pexec(command)
  puts command
  exec command
end

def apps
  @apps ||= `kubectl get pods`
    .split("\n")
    .select { |line| line.include?(app) }
    .map { |line| line.strip.split(' ').first }
    .group_by { |line| line.split('-')[0...-2].uniq.join('-') }
end

def app
  ARGV[1]
end

def matching_apps
  apps[app] || []
end

def no_matching_apps
  if apps.any?
    puts "Ambigious match name #{app}."
    puts "Maybe you meant one of the following:"
    apps.keys.each { |p| puts "    - #{p}" }
  else
    puts "No matching pods for #{app}."
  end
end

def switch_to_production
  pexec 'gcloud container clusters get-credentials production-v3 --zone us-central1-f --project pg-production-v1'
end

def switch_to_staging
  pexec 'gcloud container clusters get-credentials staging-v3 --zone us-central1-f --project pg-staging-v1'
end

def print_app_names
  puts 'Matching apps:'
  apps.keys.each { |p| puts "    - #{p}" }
end

def tail_logs
  if matching_apps.any?
    pod = matching_apps.first

    pexec "kubectl logs -f #{pod}"
  else
    no_matching_apps
  end
end

def exec_command
  if matching_apps.any?
    pod = matching_apps.first

    pexec "kubectl exec -it #{pod} #{ARGV[2..-1].join(' ')}"
  else
    no_matching_apps
  end
end

command = ARGV.first
context = `kubectl config current-context`

if context.include?('production') && ['staging', 'production'].include?(command)
  puts <<-ASCII
  _______ _     _       _                           _            _   _
 |__   __| |   (_)     (_)                         | |          | | (_)
    | |  | |__  _ ___   _ ___   _ __  _ __ ___   __| |_   _  ___| |_ _  ___  _ __
    | |  | '_ \\| / __| | / __| | '_ \\| '__/ _ \\ / _` | | | |/ __| __| |/ _ \\| '_ \\
    | |  | | | | \\__ \\ | \\__ \\ | |_) | | | (_) | (_| | |_| | (__| |_| | (_) | | | |
    |_|  |_| |_|_|___/ |_|___/ | .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|_|\\___/|_| |_|
                               | |
                               |_|
  ASCII

  5.times do |i|
    sleep 1
    print "#{5 - i} "
  end
  puts
end

if command == 'staging'
  switch_to_staging
elsif command == 'production'
  switch_to_production
elsif command == 'apps'
  print_app_names
elsif command == 'logs'
  tail_logs
elsif command == 'exec'
  exec_command
end
