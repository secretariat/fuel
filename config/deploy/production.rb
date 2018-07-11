role :web, "vs03.citrusdev.com.ua"
role :app, "vs03.citrusdev.com.ua"
role :db,  "vs03.citrusdev.com.ua", :primary => true
role :db,  "vs03.citrusdev.com.ua"

set :user, "ruby"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:auth_methods] = ["password"]
ssh_options[:port] = 22

set :deploy_to, "/home/ruby/www/fuel.citrusdev.com.ua"

namespace :deploy do

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :bundle do
    run "cd #{release_path} && bundle install --gemfile #{release_path}/Gemfile"
  end

  task :assets do
    run "cd #{release_path} && bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile"
  end

  task :migrations do
    run "cd #{release_path} && bundle exec rake db:migrate RAILS_ENV=production"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
    run "ln -nfs #{shared_path}/logos #{release_path}/public/logos"
    # run "ln -nfs #{shared_path}/output #{release_path}/public/output"
  end

  task :refresh_sitemaps do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake sitemap:refresh"
  end

  task :update_crontab do  
    run "cd #{release_path} && whenever --update-crontab #{application}"  
  end  

end
