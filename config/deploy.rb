require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'

set :application_name, 'spis'
set :domain, '10.0.0.50'
set :deploy_to, '/home/production/spis'
set :repository, 'git@github.com:nnittop909/spis.git'
set :branch, 'main'

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public/uploads')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key', 'config/puma.rb')
set :user, 'spsec'

task :environment do
  invoke :'rbenv:load'
end

task :setup do
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/master.key"]
  command %[touch "#{fetch(:shared_path)}/config/puma.rb"]
  comment "Be sure to edit '#{fetch(:shared_path)}/config/database.yml', 'master.key' and puma.rb."
end

task :deploy do
  deploy do
    comment "Deploying #{fetch(:application_name)} to #{fetch(:domain)}:#{fetch(:deploy_to)}"
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'puma:restart'
    end
  end

end