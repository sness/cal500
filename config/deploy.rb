set :svn_username, "apache"
set :application, "cal500"
set :domain, "o"
set :deploy_to, "/var/www/cal500"
set :repository, "svn+ssh://q/usr/sness/nDEVsvn/cal500"

namespace :vlad do
  set :app_command, "/etc/init.d/apache2"
  
  desc 'Restart Passenger'
  remote_task :start_app, :roles => :app do
    run "touch /var/www/cal500/current/tmp/restart.txt"
  end
  
  desc 'Restarts the apache servers'
  remote_task :start_web, :roles => :app do
    run "sudo #{app_command} restart"
  end
end
