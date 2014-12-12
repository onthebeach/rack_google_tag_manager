require 'rack_google_tag_manager'
require_relative 'app'

use Rack::GoogleTagManager, tracker: 'GTM-M2014'
use Rack::Lint
run Dummy::App.new
