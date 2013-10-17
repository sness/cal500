%w[development production].each do |env|
  desc "Runs the following task in the #{env} environment" 
  task env do
    RAILS_ENV = ENV['RAILS_ENV'] = env
  end
end

task :testing do
  RAILS_ENV = ENV['RAILS_ENV'] = 'test'
end

task :dev do
  Rake::Task["development"].invoke
end

task :pro do
  Rake::Task["production"].invoke
end
