require 'rack'
require 'erb'

class Template

  # @@template_display = ERB.new(File.read("template.html.erb"))
  @@template_display = ERB.new(File.read("template.html.erb"))

  # class << self
  #   attr_accessor :template_display
  # end

  attr_reader :coordinates

  def initialize
    @covidpoints = []
  end

  def retrieve_geoJson
    url = "https://data.ontario.ca/dataset/f4112442-bdc8-45d2-be3c-12efae72fb27/resource/4f39b02b-47fe-4e66-95b6-e6da879c6910/download/conposcovidloc.geojson"
    geoJson = open(url).read
    # # Parse geoJson data
    @covid = RGeo::GeoJSON.decode(geoJson)
  end

  def test_render
    @covidpoints << 1
  end
#
#   def sort_geoJson_to_coordinates(data)
#     @covid.sort_to_covidTO
#     test = @covid.sort_to_points_property[0]
#   end
#
# # sorting methods for geoJson data
#   def sort_to_covidTO(data)
#     @covidTO = []
#     data.each do |c|
#       if c.properties['Reporting_PHU_City'].eql?("Toronto")
#         @covidTO << c
#       end
#     end
#     @covitTO
#     # puts @covidTO[0].geometry.as_text
#   end
#
#   def sort_to_points_property(data)
#     @coordinates = []
#     data.each do |property|
#       @coordinates << property.geometry.as_text
#     end
#     @coordinates
#   end

  # bind and render the template
  # by moving .result(binding) here, does this mean I can
  # now access my instance variables properly?!
 def bind_and_render
   @@template_display.result(binding)
 end
end

# The Template as a global variable
$template = Template.new

# handler for successful get requests, app has no post
def successful_get_request(req)
  resp = Rack::Response.new
  resp.status = 200
  resp.set_header('Content-Type', 'text/html')
  # resp.write("This is your body")
  resp.write $template.bind_and_render
  # resp.write(Template::template_display)
  p resp
  # resp.finish
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
  routes(req).finish
  end

  Rack::Static.new(app, :urls => ["/static"])
end

Rack::Handler::WEBrick.run app_server
