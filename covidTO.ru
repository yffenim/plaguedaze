require 'rack'
require 'erb'
require 'json'
require 'rgeo/geo_json'
require 'open-uri'
require 'singleton'
require 'bundler'

# do i need a require bundler and what is it actually doing?


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

  # class object of template so that we can access api data
  @@template_display = ERB.new(File.read("template.html.erb"))

  # initializing empty arrays for data to play with
  def initialize
    @covidTO = []
    @cities = []
    @test = 123
  end

  # getting and sorting covid data
  def retrieve_geoJson
    puts 'inside retrieve method'
    url = 'https://data.ontario.ca/dataset/f4112442-bdc8-45d2-be3c-12efae72fb27/resource/4f39b02b-47fe-4e66-95b6-e6da879c6910/download/conposcovidloc.geojson'

    puts 'before read method on url'
    geoJson = open(url).read
    # # Parse geoJson data
    puts 'before decode method on geo'
    @covid = RGeo::GeoJSON.decode(geoJson)

    # puts 'before selecting'
    # puts @covid[0]
    # puts @covid.size


    # to do:
    # 1. go through original data set and find the total cases per unique city
    # 2. create a hash containing each unique city as key and value as the total cases


    # unique_cities = @covid.uniq {|covid| covid.properties['Reporting_PHU_City'] }
    # unique_cities.each do |uniq|
    #   @cities << uniq.properties['Reporting_PHU_City']
    # end
    #

    # create a hash of all cities to store total covid cases
    # unique_cities = @covid.uniq {|covid| covid.properties['Reporting_PHU_City'] }
    # now i have an array of geoJson objects of unique cities and i want to create a hash
    # where the key is the city name and the value is the total count of cases

    # city_hash = Hash.new
    #
    # unique_cities.each do |city_name|
    # # I need to count the total unresolved cases of each unique city
    # # this means I need the original dataset prior to it being sorted?
    #
    #   city_cases = city_name.properties['Reporting_PHU_City'].eql?("Toronto") && c.properties['Outcome1'].eql?('Not Resolved')
    #
    #   city_hash[city_name.properties['Reporting_PHU_City']] = 0
    # end
    # puts city_hash


    # puts 'before sorting by toronto'

    # @Toronto = []
    # @covid.each do |c|
    #   if c.properties['Reporting_PHU_City'].eql?("Toronto") && c.properties['Outcome1'].eql?('Not Resolved')
    #     @Toronto << c
    #   end
    # end
    #
    # # save covid cases into each city's hash value
    # city_hash['Toronto'] = city_hash['Toronto'] + @Toronto.size
    # puts city_hash['Toronto']

    # puts @Toronto.size
    # sort data by Toronto + unresolved cases
    # @covid.each do |c|
    #   if c.properties['Reporting_PHU_City'].eql?("Toronto") && c.properties['Outcome1'].eql?('Not Resolved')
    #     @covidTO << c
    #   end
    # end
    #

    # sort covid data into coordinates
    # @covidTO.each do |property|
    #   @coordinates << property.geometry.as_text
    # end

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
