MODELS = FileList['app/models/*rb'] ##.exclude(/.*_.*/)

def dump_all_models
  MODELS.each do |m|
    name = File.basename(m,'.rb').camelize
    model = eval name
    if model.methods.include? "dump_to_file"
      yaml_name = "db/" + File.basename(m,'.rb') + ".yml"
      puts "Dumping #{name} to #{yaml_name}"
      model.dump_to_file
    end
  end
end

def load_all_models
  MODELS.each do |m|
    name = File.basename(m,'.rb').camelize
    model = eval name
    if model.methods.include? "load_from_file"
      if ENV['DBPATH'].blank?
        path = nil
      else
        path = ENV['DBPATH'] + "/" + File.basename(m,'.rb') + "s.yml"
        if (!File.exists?(path))
          puts "*** File (#{path}) does not exist, skipping"
          next
        end
      end
      puts "Loading #{name} #{path}"
      model.load_from_file(path)
    end
  end
end

namespace :db do
  namespace :dump do

    desc "Dump all models to .yml files in db/ directory"
    task :all => [:environment] do
      dump_all_models
    end
  end
end

namespace :db do
  namespace :load do

    desc "Load all models from .yml files in db/ directory, or from the environment variable DBPATH"
    task :all => [:environment] do
      load_all_models
    end

  end
end
