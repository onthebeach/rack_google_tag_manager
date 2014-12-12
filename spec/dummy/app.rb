module Dummy
  class App
    def call(env)
      [200, {"Content-Type" => "text/html"}, response]
    end

    private

    def response
      [::File.read(::File.expand_path('../response.html', __FILE__))]
    end
  end
end
