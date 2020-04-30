$:.unshift File.dirname(__FILE__)

require 'erb'
require 'json'
require 'bundler'

# to do's:
# figure out this load path issue because my ENV isn't getting accessed
# reorganize everything into separate modules
# figure out how to click a download for something that isn't an api

class Template
    attr_reader :google_api_key
  # create a template for response body
    @template_display = ERB.new(File.read("template.html.erb")).result(binding)
    # @template_display.result(binding)
  # setting self to Template's metaclass so that it is a "layer" above
  # and template_display can be accessible like a class variable? Rewwrite?
    class << self
      attr_accessor :template_display
    end

    attr_accessor :google_api_key
  # trying to hide my api key in env but it is
  # still going to how up front end in browser?
    # key = File.read(".env")
    # puts key
    #
    # @google_api_key = %(https://maps.googleapis.com/maps/api/js?key=#{key}&callback=initMap)
    # puts @google_api_key

end




# MapsApi.new(key)



# Handling request

def handle_request_object(req)
  if req.path != "/"
     [404, { "Content-Type" => "text/html" }, ["<h1>404</h1>"]]
  else
    check_method(req)
  end
end

def check_method(req)
  if req.get?
    successful_get_request
  else
    unsuccessful_request
  end
end

def successful_get_request
  resp = Rack::Response.new
  resp.status = 200
  resp.set_header('Content-Type', 'text/html')
  resp.write(Template::template_display)
  p resp

  resp.finish
end

def unsuccessful_request
  # [200, {'Content-Type' => 'text/plain'},
  # ["No hakkerz plz"]]
end


# Serving the final response object
def final_app_server
  # app is my rack app, it needs to return an array of status, header, body
  app = Proc.new do |env|
  # Creating a proc because each app instance needs to remember its env context
  # which I then assemble:
    req = Rack::Request.new(env)
    handle_request_object(req)
  end
# use rack static as middleware here
  Rack::Static.new(app, :urls => ["/static"])
end

# call run on the app
run final_app_server
