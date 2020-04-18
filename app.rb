require 'rack'
# require 'erb'

def call(env)
  req = Rack::Request.new(env)
  case req.path_info
  when /hello/
end


Rack::Handler::WEBrick.run(app, options = {})



# I need my app to:
#
# - listen to a get request from my client
# - return the ip address of my client
