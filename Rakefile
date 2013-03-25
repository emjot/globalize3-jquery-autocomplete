require 'bundler/setup'
require 'rspec/core/rake_task'

require 'bundler/gem_tasks'

desc 'Default: Run all tests'
task :default => :spec

desc 'Run all tests'
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end
