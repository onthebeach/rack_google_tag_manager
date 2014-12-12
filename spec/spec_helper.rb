ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'rack_google_tag_manager'
require 'support/mock_app_helper'
require 'rack/test'

RSpec.configure do |config|
  include MockAppHelper
end
