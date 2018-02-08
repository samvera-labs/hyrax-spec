#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'engine_cart/rake_task'

Bundler::GemHelper.install_tasks

desc 'Run style checker'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec)

desc 'Start dummy appliication with engine_cart'
task :setup_test_server do
  require 'engine_cart'
  EngineCart.load_application!
end

desc 'Check style and run specs'
task ci: ['rubocop', 'engine_cart:generate', 'setup_test_server', 'spec']

task default: :ci
