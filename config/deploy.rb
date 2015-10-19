# -*- encoding : utf-8 -*-
require "whenever/capistrano"
require 'capistrano/ext/multistage'
require "bundler/capistrano"
require 'whenever/capistrano/recipes'
require "whenever/capistrano"


set :application, "fuel"
set :scm, :git
set :scm_verbose, true

set :default_shell, '/bin/bash -l'

set :repository,  "git@github.com:secretariat/fuel.git"
set :branch, 'develop'

set :deploy_via, :copy
set :use_sudo, false
set :keep_releases, 5

set :stages, ["staging", "production"]
set :default_stage, "production"

after "deploy","deploy:bundle"
after "deploy:bundle", "deploy:symlink_shared"
after "deploy:symlink_shared", "deploy:update_crontab"  
after "deploy:update_crontab", "deploy:assets"
after "deploy:assets", "deploy:migrations"
after "deploy:migrations", "deploy:restart"
after "deploy:create_symlink", 'whenever:update_crontab'
after "whenever:update_crontab","deploy:cleanup"

set :whenever_command, "bundle exec whenever"
