require 'rack'


# handling successful get requsts

def successful_get_request(req)
  resp = Rack::Response.new
  resp.status = 200
  resp.set_header('Content-Type', 'text/html')
  resp.write("This is your body")
  # resp.write(Template::template_display)
  p resp
  resp.finish
end

# handler for server requests (routes)
def routes(req)
  if req.path != "/"
     [404, { "Content-Type" => "text/html" }, ["<h1>404</h1>"]]
  else
    successful_get_request(req)
  end
end


# the server
def app_server
  app = Proc.new do |env|
  req = Rack::Request.new(env)
  routes(req)
  end
end

Rack::Handler::WEBrick.run app_server
