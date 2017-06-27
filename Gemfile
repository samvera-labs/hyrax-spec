# frozen_string_literal: true
source "https://rubygems.org"

# Please see hyrax-spec.gemspec for dependency information.
gemspec

group :development, :test do
  gem 'coveralls', require: false
  gem 'guard',     require: false
  gem 'pry'        unless ENV['CI']
  gem 'pry-byebug' unless ENV['CI']
  gem 'simplecov', require: false
end
