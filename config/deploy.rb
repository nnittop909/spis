require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/bundler'
require 'mina/puma'

set :application_name, 'spis'
set :domain, '10.0.0.66'
set :deploy_to, '/home/deploy/spis'
set :repository, 'git@github.com:nnittop909/spis.git'
set :branch, 'main'

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public/uploads', 'vendor/bundle', 'storage')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key', 'config/puma.rb')
set :user, 'deploy'
# set :bundle_options, -> { '' }

task :environment do
  invoke :'rbenv:load'
end

task :setup do
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/log"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/tmp/pids"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/tmp/sockets"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/public/uploads"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/vendor/bundle"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/storage"]

  # command "#{fetch(:bundle_bin)} config set deployment 'true'"
  # command "#{fetch(:bundle_bin)} config set path '#{fetch(:bundle_path)}'"
  # command "#{fetch(:bundle_bin)} config set without '#{fetch(:bundle_withouts)}'"

  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/master.key"]
  command %[touch "#{fetch(:shared_path)}/config/puma.rb"]
  comment "Be sure to edit '#{fetch(:shared_path)}/config/database.yml', 'master.key' and puma.rb."
end

task :deploy do
  deploy do
    invoke :'rbenv:load'
    comment "Deploying #{fetch(:application_name)} to #{fetch(:domain)}:#{fetch(:deploy_to)}"
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    command %{#{fetch(:rails)} db:seed}
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'
  end
end

task :launch do
  invoke :'puma:phased_restart'
end