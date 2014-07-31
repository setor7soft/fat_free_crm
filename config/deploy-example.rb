# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
$:.unshift File.expand_path('./lib', ENV['rvm_path'])

require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'capistrano-unicorn'
load    'deploy/assets'


set :stages, ["staging", "production"]
set :default_stage, "staging"
set :application,     ''
set :repository,      ''
set :branch,          'master'
set :scm,             :git
set :user,            ''
#set :rvm_path, '/usr/local/rvm'
#set :use_sudo,        false
#set :rvm_type,        :user
#set :rvm_ruby_string, '2.1.2'
set :bundle_flags, ''
server "", :app, :web, :db, :primary => true

# Use local key instead of key installed on the server.
# If not working run "ssh-add ~/.ssh/id_rsa" on your local machine.
ssh_options[:forward_agent] = true


namespace :deploy do
  desc 'Symlink shared configs and folders on each release.'
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
    run "rm -rf #{release_path}/vendor/ruby"
    run "ln -nfs #{shared_path}/bundle/ruby #{release_path}/vendor/ruby"
  end
end



# if you want to clean up old releases on each deploy uncomment this:
after 'deploy:restart', 'deploy:cleanup'

after 'deploy:finalize_update', 'deploy:symlink_shared'
after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'   # app preloaded
#after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)
