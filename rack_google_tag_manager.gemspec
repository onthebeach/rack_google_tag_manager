# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/google_tag_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack_google_tag_manager'
  spec.version       = Rack::GoogleTagManager::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Ancor Cruz']
  spec.email         = ['hello@ancorcruz.com']
  spec.summary       = %q{Rack Middleware to inject Google Tag Manager code snippet into server html responses for rack based applications}
  spec.description   = %q{Rack Middleware to inject Google Tag Manager code snippet into server html responses for rack based applications}
  spec.homepage      = 'https://github.com/onthebeach/rack_google_tag_manager'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'simplecov'
end
