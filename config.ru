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

class RackAppRoutes

  def call(env)
    req = Rack::Request.new(env)
    if req.get?
      [200, {'Content-Type' => 'text/plain'},
      ["This is a successful get request!"]]
    else
    unsuccessful_request
    end
  end

  def successful_get_request(env)

  end

end

# create an instance of the app and store it in app variable
app = RackAppRoutes.new

# call run on the app
run app
