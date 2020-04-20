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

# class MainPage
#   # render tempalte
#
#   # receive api object
#   def receive_api
#   end
#
#
#
# end



class RackApp
# create a template for response body
  @@template = ERB.new File.read("template.html.erb")

# render the static html template
  def render_template
    @@template
  end

# since I am instantiating a class, I need to have a call method
  def call(env)
    req = Rack::Request.new(env)
    if req.get?
      successful_get_request
    else
      unsuccessful_request
    end
  end

  def successful_get_request
    resp = Rack::Response.new
    resp.status = 200
    resp.set_header('Content-Type', 'text/plain')
    resp.write(@@template)
    resp.finish
    # [200, {'Content-Type' => 'text/plain'},
    # ["This is a successful get request!"]]
  end

  def unsuccessful_request
  end

end

# create an instance of the app and store it in app variable
app = RackApp.new

# call run on the app
run app
