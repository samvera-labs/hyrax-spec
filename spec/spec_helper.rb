require 'bundler/setup'

begin
  require 'simplecov'
  require 'coveralls'
rescue LoadError => e
  STDERR.puts "Coverage Skipped: #{e.message}"
end

begin
  require 'pry' unless ENV['CI']
rescue LoadError => e
  STDERR.puts "Couldn't load Pry: #{e.message}"
end

RSpec.configure do |config|
  config.filter_run_excluding :slow
  config.run_all_when_everything_filtered = true

  # disable should syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
