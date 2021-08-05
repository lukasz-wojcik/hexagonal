# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require_relative '../config/boot'
require 'database_cleaner/mongoid'

RSpec.configure do |config|
  DatabaseCleaner.strategy = :deletion

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.after(:example) do
    ParkingCars::Configuration.rates_repository.destroy_all
  end

  config.around(:each, integration: true) do |example|
    DatabaseCleaner[:mongoid].cleaning do
      example.run
    end
  end
end
