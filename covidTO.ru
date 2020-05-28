require 'rack'
require 'erb'
require 'json'
require 'rgeo/geo_json'
require 'open-uri'
require 'singleton'
require 'pry'

# New Version of App based on new data:

# Part 1: Giant amChart of all data
# sort data into variables for chart and make chart
# make page so that a table of current covid cases appears
# click to chart it, table fades, chart appears
# click to map the cases per city

# Part 2: Click on your city to render a
# google heat map of cases there
# have this randomly generated
# but accurately reflects how many cases there are

# Part 3: security
# 1. figure out env/yaml for api
# 2. maybe implement a login & auth
# 3. something about cookies?


class Template
  include Singleton

  # class object of template so that we can access api data
  @@template_display = ERB.new(File.read("template.html.erb"))

# bind and render method for template class obj
# for when it is initialized later in response body
   def bind_and_render
     @@template_display.result(binding)
   end

   def google_api_call
   end

  def retrieve_geoJson
    puts 'inside retrieve method'
    url = 'https://data.ontario.ca/dataset/f4112442-bdc8-45d2-be3c-12efae72fb27/resource/4f39b02b-47fe-4e66-95b6-e6da879c6910/download/conposcovidloc.geojson'

    puts 'before read method on url'
    geoJson = open(url).read
    # # Parse geoJson data
    puts 'before decode method on geo'
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

# under 100

  def penbroke
    @city_hash["Penbroke"]
  end

  def waterloo
    @city_hash["Waterloo"]
  end

  def oakville
    @city_hash["Oakville"]
  end

  def barrie
    @city_hash["Barrie"]
  end

  def peterborough
    @city_hash["Peterborough"]
  end

  def thorold
    @city_hash["Thorold"]
  end

  def thunderbay
    @city_hash["Thunder Bay"]
  end

  def chatham
    @city_hash["Chatham"]
  end

  def cornwall
    @city_hash["Cornwall"]
  end

  def guelph
    @city_hash["Guelph"]
  end

  def brantford
    @city_hash["Brantford"]
  end

  def porthope
    @city_hash["Port Hope"]
  end

  def kenora
    @city_hash["Kenora"]
  end

  def simcoe
    @city_hash["Simcoe"]
  end

  def brockville
    @city_hash["Brockville"]
  end

  def timmmins
    @city_hash["Timmins"]
  end

  def stthomas
    @city_hash["St. Thomas"]
  end

  def pointedward
    @city_hash["Point Edward"]
  end

  def saultstemarie
    @city_hash["Sault Ste. Marie"]
  end

  def london
    @city_hash["London"]
  end

  def northbay
    @city_hash["North Bay"]
  end

  def owensound
    @city_hash["Owen Sound"]
  end

  def stratford
    @city_hash["Stratford"]
  end

  def belleville
    @city_hash["Belleville"]
  end

  def kingston
    @city_hash["Kingston"]
  end

  def sudbury
    @city_hash["Sudbury"]
  end

  def newliskeard
    @city_hash["New Liskeard"]
  end


  end
end



# handler for successful get requests, app has no post
def successful_get_request(req)
  resp = Rack::Response.new
  resp.status = 200
  resp.set_header('Content-Type', 'text/html')
  # resp.write("This is your body")
  resp.write Template.instance.bind_and_render

  # resp finish method needs to be here because it is a
  # Rack::Response object method so having it in my app sever
  # method will throw errors for the server responses that
  # are not Rack::Reponse objects
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
