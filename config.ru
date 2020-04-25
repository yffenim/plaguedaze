# Iteration 1: Rewrite this into ruby method
#
# run -> env {
#   [200, {'Content-Type' => 'text/plain'},
#     ["Your IP: #{env['REMOTE_ADDR']}"]]
#   }

# what I know:
# - run is a built-in ruby web server method that expects a rack app
# as its argument
# - the lambda above is my app so I am calling run on the env hash
#
# - to rewrite this, I therefore need:
# 1. a run
# 2. a method has to be called somewhere
# 3. a method that contains the env hash-like
# info that the call returns


# class RackAppGetRequests
#
#   def call(env)
#     # use env as argument for the call method
#     [200, {'Content-Type' => 'text/plain'},
#     ["This is a successful get request!"]]
#   end
# end

require 'erb'

class Template
  # test out how to render an ERB
    # ERB.new(<h1>Erb Rendering</h1>).result.binding
    # @erb_object = ERB.new("<h1>Erb Rendering</h1>").result(binding)

  # create a template for response body
    @template_display = ERB.new(File.read("template.html.erb")).result(binding)
    # @template_display.result(binding)
  # setting self to Template's metaclass so that it is a "layer" above
  # and template_display can be accessible like a class variable? Rewwrite?
    class << self
      attr_accessor :template_display
      # attr_accessor :erb_object
    end

  # receive api object
  def receive_api
  end

end

# class RackApp
  # attr_reader :html
# since I am instantiating a class, I need to have a call method
  # def call(env)
  # # Create a request object
  #   @req = Rack::Request.new(env)
  #   handle_request_object
  # end

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
    # resp.write(Template::erb_object)
    resp.write(Template::template_display)
    p resp

    resp.finish

    # serve static files
    # Rack::Static.new(resp, :urls => ["/static"])
    # [200, {'Content-Type' => 'text/plain'},
    # ["This is a successful get request!"]]
  end

  def unsuccessful_request
    # [200, {'Content-Type' => 'text/plain'},
    # ["No hakkerz plz"]]
  end

# end

def final_app_server
  # app is my rack app, it needs to return an array of status, header, body
  app = Proc.new do |env|
  # Creating a proc because each app instance needs to remember its env context
  # which I then assemble:
    req = Rack::Request.new(env)
    handle_request_object(req)
  end
# returns an array env that can be served as argument to a run
# use rack static as middleware here
end

# call run on the app
run final_app_server
