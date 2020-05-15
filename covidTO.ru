require 'rack'
require 'erb'
require 'json'
require 'rgeo/geo_json'
require 'open-uri'
require 'singleton'
require 'bundler'


# do to (immediate list)

# use openmaps api to get coordinates:
# - loop over geoJson data to extract addresses for Toronto cases
# - send them to openmaps
# - only do this for the most recently 2 weeks of cases
# - put coordinates into google maps api

# set up api env variable first
# set it up with yaml file for security reasons

# figure out format google api wants
# make api key hidden


class Template
  include Singleton

  # attr_reader :coordinates

  # class object of template so that we can access api data
  @@template_display = ERB.new(File.read("template.html.erb"))

  # initializing empty arrays for data to play with
  def initialize
    @covidTO = []
    @addresses = []
    @coordinates = []
    @pointx = []
    @pointy = []
    @test = 123
  end
  #
  # def testpoint
  #   43.6532, -79.3801
  # end

  # getting and sorting covid data
  def retrieve_geoJson
    puts 'inside retrieve method'
    url = 'https://data.ontario.ca/dataset/f4112442-bdc8-45d2-be3c-12efae72fb27/resource/4f39b02b-47fe-4e66-95b6-e6da879c6910/download/conposcovidloc.geojson'

    puts 'before read method on url'
    geoJson = open(url).read
    # # Parse geoJson data
    puts 'before decode method on geo'
    @covid = RGeo::GeoJSON.decode(geoJson)
    puts 'before sorting into toronto, here is first covid obj:'
    # puts @covid[0..5]

    # puts @covid.size
    # only use last 50 cases for now
    @covid = @covid[-50..-1]
    # puts @covid.size

    # sort data by Toronto + unresolved cases
    @covid.each do |c|
      if c.properties['Reporting_PHU_City'].eql?("Toronto") && c.properties['Outcome1'].eql?('Not Resolved')
        @covidTO << c
      end
    end

    puts 'after mapping by city'
    # only use 20 cases for this iteration of app
    @covidTO =  @covidTO[-20..-1]

    # sort covid data into coordinates
    # @covidTO.each do |property|
    #   @coordinates << property.geometry.as_text
    # end
    #
    # puts 'after getting coordinates'
    # puts @coordinates.size

  end

  def pointx
    @pointx
  end

  def pointy
    @pointy
  end

  def test_initialize
    @test
  end

  def test_render
    "Here is string inside test_render method"
  end

  def test_coordinates
    @coordinates[0]
    @coordinates[0].class
  end





# bind and render method for template class obj
# for when it is initialized later in response body
   def bind_and_render
     @@template_display.result(binding)
   end

   def google_api_call
   end

end


# handler for successful get requests, app has no post
def successful_get_request(req)
  resp = Rack::Response.new
  resp.status = 200
  resp.set_header('Content-Type', 'text/html')
  # resp.write("This is your body")
  resp.write Template.instance.bind_and_render
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

# serve static resources
  Rack::Static.new(app, :urls => ["/static"])
end

run app_server
