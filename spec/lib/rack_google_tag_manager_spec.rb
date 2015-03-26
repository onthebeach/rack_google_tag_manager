require 'spec_helper'

module Rack
  describe GoogleTagManager do
    let(:tracker_id) { 'GTM-FAKEID' }
    let(:middleware) { described_class.new(mock_app, tracker: tracker_id) }
    let(:request) { Rack::MockRequest.new(middleware) }

    context 'for a text/html response' do
      subject { request.get('/').body }

      it 'adds the container snippet after body tag' do
        expect(subject).to match(%r[<body.*?>.*#{tracker_id}.*Works!<\/body>]m)
      end
    end

    context 'for a text/html response with uppercase html tags' do
      subject { request.get('/uppercase_tags.html').body }

      it 'adds the container snippet after body tag' do
        expect(subject).to match(%r[<BODY.*?>.*#{tracker_id}.*Works!<\/BODY>]m)
      end
    end

    context 'for a text/html response without body tag' do
      subject { request.get('/fragment.html').body }

      it 'does not add the container snippet' do
        expect(subject).not_to include(tracker_id)
      end

      it 'does not modify the response' do
        expect(subject).to eq(mock_html_fragment)
      end
    end

    context 'for no text/html responses' do
      subject { request.get('/test.json').body }

      it 'does not add the container snippet' do
        expect(subject).not_to include(tracker_id)
      end

      it 'does not modify the response' do
        expect(subject).to eq(mock_json_response)
      end
    end
  end
end
