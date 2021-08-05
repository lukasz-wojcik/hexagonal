# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'activesupport', '~> 6.1.4'

gem 'dry-container', '~> 0.8.0'
gem 'dry-struct', '~> 1.4'
gem 'mongoid', '~> 7.3.1'

gem 'rubocop'
gem 'zeitwerk'

group :development, :test do
  gem 'pry'
  gem 'rspec', '~> 3.10.0'
end

group :test do
  gem 'database_cleaner-mongoid', '~> 2.0.1'
end
