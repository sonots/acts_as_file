# coding: utf-8
require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ["-c", "-f progress"] # '--format specdoc'
      t.pattern = 'spec/**/*_spec.rb'
end
task :test => :spec
task :default => :spec

desc 'Open an irb session preloaded with the gem library'
task :console do
  sh 'irb -rubygems -I lib -r acts_as_file'
end
task :c => :console
