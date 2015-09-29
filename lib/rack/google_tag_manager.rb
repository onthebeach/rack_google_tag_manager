require 'rack'

module Rack
  class GoogleTagManager
    def initialize(app, tracker: nil)
      @app, @tracker = app, tracker
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      @status, @headers, @body = app.call(env)
      return [@status, @headers, @body] unless html_response?

      response = Rack::Response.new([], @status, @headers)
      @body.each { |fragment| response.write(inject_in(fragment)) }

      @body.close if @body.respond_to?(:close)

      response.finish
    end

    private

    attr_reader :app, :tracker

    def html_response?
      @headers['Content-Type'] =~ %r{text/html}
    end

    def inject_in(response)
      response.sub(open_body_tag_regex, "\\0\n#{container_snippet}")
    end

    def open_body_tag_regex
      %r{<body.*?>}im
    end

    def container_snippet
      @container_snippet ||= <<-EOS
<!-- Google Tag Manager -->
<noscript>
  <iframe src="//www.googletagmanager.com/ns.html?id=#{tracker}"
    height="0" width="0" style="display:none;visibility:hidden">
  </iframe>
</noscript>

<script>
  (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
  new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
  j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
  '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
  })(window, document, 'script', 'dataLayer', '#{tracker}');
</script>
<!-- End Google Tag Manager -->
      EOS
    end
  end
end
