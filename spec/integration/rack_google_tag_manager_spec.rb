require 'spec_helper'

describe Rack::GoogleTagManager do
  include Rack::Test::Methods

  let(:tracker_id) { 'GTM-M2014' }
  let(:app) { Rack::Builder.parse_file(app_rackup_file).first }
  let(:app_rackup_file) {
    ::File.expand_path('../../dummy/config.ru', __FILE__)
  }

  before { get '/' }

  it { expect(last_response).to be_ok }

  it 'includes google tag manager container snippet' do
    expect(last_response).to match(%r[<body.*?>.*#{tracker_id}.*<h1>.*<\/body>]m)
  end
end
