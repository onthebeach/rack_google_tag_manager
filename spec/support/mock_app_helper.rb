module MockAppHelper
  def mock_app
    -> (env) {
      request = Rack::Request.new(env)
      case request.path
      when '/' then
        [200, { 'Content-Type' => 'text/html' }, [mock_html_response]]
      when '/test.json' then
        [200, { 'Content-Type' => 'application/json' }, [mock_json_response]]
      when '/fragment.html' then
        [200, { 'Content-Type' => 'text/html' }, [mock_html_fragment]]
      when '/uppercase_tags.html' then
        [200, { 'Content-Type' => 'text/html' }, [mock_uppercase_tags_response]]
      else
        [404, 'Not found']
      end
    }
  end

  def mock_html_response
    '<body class="main">Works!</body>'
  end

  def mock_html_fragment
    '<div>it is a fragment of html</div>'
  end

  def mock_json_response
    '{"json":"here"}'
  end

  def mock_uppercase_tags_response
    '<BODY>Works!</BODY>'
  end
end
