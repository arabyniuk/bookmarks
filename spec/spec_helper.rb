ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'devise'
require 'factory_girl_rails'
require 'subdomain'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include RequestMacros, :type => :request
  config.include Devise::TestHelpers, :type => :controller
  config.include(OmniauthMacros)
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

 config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

OmniAuth.config.test_mode = true
