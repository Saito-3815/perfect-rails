ENV['RAILS_ENV'] ||= 'test'

# require 'coveralls'
# Coveralls.wear!('rails')
require 'simplecov'
SimpleCov.start 'rails'

require_relative '../config/environment'
require_relative 'sign_in_helper'
require 'rails/test_help'
require 'minitest/mock'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Add more helper methods to be used by all tests here...

#   Rails.logger = Logger.new(STDOUT)
#   Rails.logger.level = :debug
end
