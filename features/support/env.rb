require 'cucumber/rails'
require 'factory_bot'
require 'cucumber/rspec/doubles'
require 'capybara/cucumber'
load 'spec/factories.rb'
require "#{Rails.root}/features/support/stubs"

# Clean the database before and after each scenario
Before do
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
end

# Register Chrome as the default driver
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

# FactoryBot
World(FactoryBot::Syntax::Methods)
