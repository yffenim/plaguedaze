require 'rack'
require 'erb'
require 'json'
require 'rgeo/geo_json'
require 'open-uri'
require 'singleton'
require 'pry'



class Template
  include Singleton

  # class object of template so that we can access api data
  @@template_display = ERB.new(File.read("template.html.erb"))

  # bind and render method for template class obj
  # for when it is initialized later in response body
  def bind_and_render
     @@template_display.result(binding)
  end

  def retrieve_geoJson
    url = 'https://data.ontario.ca/dataset/f4112442-bdc8-45d2-be3c-12efae72fb27/resource/4f39b02b-47fe-4e66-95b6-e6da879c6910/download/conposcovidloc.geojson'
    geoJson = open(url).read
    # Parse geoJson data
    @covid = RGeo::GeoJSON.decode(geoJson)

    # method to find total case count per unique city
    def find_case_count(city_string)
      cases = []
      @covid.each do |c|
        if c.properties['Reporting_PHU_City'].eql?(city_string) && c.properties['Outcome1'].eql?('Not Resolved')
          cases << c
        end
      end
      cases.count
    end

    # create a new hash to contain city => cases data
    @city_hash = Hash.new
    # for each unique city from @covid dataset, set its value to 0 in the hash
    unique_cities = @covid.uniq {|covid| covid.properties['Reporting_PHU_City'] }

    unique_cities.each do |city_name|
      name_string = city_name.properties['Reporting_PHU_City']
      @city_hash[name_string] = find_case_count(name_string)
    end

    # to be refactored later... x___x
    def mississauga
      @city_hash["Mississauga"]
    end

    def newmarket
      @city_hash["Newmarket"]
    end

    def toronto
      @city_hash["Toronto"]
    end

    def whitby
      @city_hash["Whitby"]
    end

    def hamilton
      @city_hash["Hamilton"]
    end

    def ottawa
      @city_hash["Ottawa"]
    end

    def windsor
      @city_hash["Windsor"]
    end
  end
end

# handler for successful get requests, app has no post
def successful_get_request(req)
  resp = Rack::Response.new
  resp.status = 200
  resp.set_header('Content-Type', 'text/html')
  resp.write Template.instance.bind_and_render
  resp.finish
end


# handler for server requests (routes)
def routes(req)
  if req.path == "/"
    successful_get_request(req)
  else
    [404, { "Content-Type" => "text/html" }, ["<h1>404</h1>"]]
  end
end

# the server
def app_server
  app = Proc.new do |env|
    req = Rack::Request.new(env)
    routes(req)
  end
# serve static resources
  Rack::Static.new(app, :urls => ["/static"])
end

run app_server
