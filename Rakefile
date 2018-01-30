require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :descargar_xslt do
  ruby 'rake/descargar_xslt.rb'
end
