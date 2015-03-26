# Rack Google Tag Manager [![Build Status](https://travis-ci.org/onthebeach/rack_google_tag_manager.svg)](https://travis-ci.org/onthebeach/rack_google_tag_manager)

Rack Middleware to inject [Google Tag Manager](https://developers.google.com/tag-manager/)
code snippet into all html responses with body tag for rack based applications.

## Installation

Add this line to your application's Gemfile:

    gem 'rack_google_tag_manager'

And then execute:

    $ bundle install

## Usage

### Rails

Add this line to your application's config/application.rb:

    config.middleware.use 'Rack::GoogleTagManager', tacker: 'GTM-XXXXXX'

To pass inforamtion to GTM from your application you can do it with a JavaScript
array called *dataLayer*. There are two ways to use it:

1. `dataLayer = [{ 'data': 'myData' }]`
2. `dataLayer.push({ 'data': 'myData' })`

The first one will overwrite all existing values that were previously
passed to the service, while the second will append the new values to
the existing ones.

In order for the `push` API so be usable, the *dataLayer* must first be
declared as an array, the GTM JavaScript snippet inserted at the
top of the body will declare it for you.

If your *tags* need to fire when pages load, but need information beyond URL
and referrer, you may need to define the *dataLayer* and pushes information to
it. Add this code above the container snippet so that the data layer information
is available on page load. Note that every page must have the code to create a
*dataLayer* and push information to it; the *dataLayer* does not persist across
pages.

## Contributing

1. Fork it ( http://github.com/onthebeach/rack_google_tag_manager/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
