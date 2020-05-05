# $:.unshift File.dirname(__FILE__)
require 'erb'
require 'json'
require 'rgeo/geo_json'
require 'open-uri'
require 'bundler'

# to do's:
# sort data to get coordinates only
# put data coordinates on map regardless of sorting for now
# extend heatmap range so that GTA is covered, not just Toronto or
# iterate over geoJson data to get coordinates only for downtown Toronto
# figure out how to hide damn api key
# find a way to sort the data based on resolved, current, or pending cases
# implement various sort/searching methods

# reorganize everything into separate modules
# figure out how to click a download for something that isn't an api
#
# str2 = '{"type":"Feature","geometry":{"type":"Point","coordinates":[2.5,4.0]},"properties":{"color":"red"}}'
# feature = RGeo::GeoJSON.decode(str2)
# feature['color']          # => 'red'
# feature.geometry.as_text  # => "POINT (2.5 4.0)"
#

# Get geoJson data
geoJson = open("https://data.ontario.ca/dataset/f4112442-bdc8-45d2-be3c-12efae72fb27/resource/4f39b02b-47fe-4e66-95b6-e6da879c6910/download/conposcovidloc.geojson").read
# Parse geoJson data
covid = RGeo::GeoJSON.decode(geoJson)
puts one = covid[0].properties['Reporting_PHU_City']

# puts one.geometry.as_text
# puts one.class
# puts one.methods.sort

# write method to sort tho
# def covidToronto(covid)
  covidTO = []
  covid.each do |c|
    if c.properties['Reporting_PHU_City'].eql?("Toronto")
      covidTO << c
    end
  end
  # covidTO
# end

puts covidTO[0].properties['Reporting_PHU_City']

# puts geoObj[1]
# puts geoObj[2]

# puts geoObj[0].geometry.as_text


# I want the objects that are from toronto
# I want their geometry coordinates



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
