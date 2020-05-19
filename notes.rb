covidTO = []
# covid.map do |c|
covidTO = covid.take_while {|c| c.properties['Reporting_PHU_City'].eql?("Toronto") }
  # end
puts covid[0].properties['Reporting_PHU_City']


<h2>
  <% retrieve_geoJson %>
</h2>


<h2> Testing initialize:
   <%= test_initialize %>
</h2>

<h2> Testing render method:
   <%= test_render %>
</h2>

<h2> Testing coordinates:
   <%= test_coordinates %>
</h2>

<!-- <script src="static/scripts.js">
</script> -->


@pointx = []
@pointy = []

@coordinates.each do |obj|
  obj = obj.chars
  for i in 7..14
    @pointx << obj[i]
    @pointx.join("")
  end

  for i in 20..26
    @pointy << obj[i]
    @pointy.join("")
  end
end

puts 'after getting points'
puts @pointx


<button id="click" onclick="clickFunction()">Click to download GeoJson</button>

<button type="button"
onclick="document.getElementById('click').innerHTML = Date()">
Click me to display Date and Time.</button>
<div id="map"></div>


# this is old code:
    # unique_cities = @covid.uniq {|covid| covid.properties['Reporting_PHU_City'] }
    # unique_cities.each do |uniq|
    #   @cities << uniq.properties['Reporting_PHU_City']
    # end
    #
    # puts @cities


# find cases in Toronto
    # toronto_cases = []
    # @covid.each do |c|
    #   if c.properties['Reporting_PHU_City'].eql?("Toronto") && c.properties['Outcome1'].eql?('Not Resolved')
    #     toronto_cases << c
    #   end
    # end
    #
    # @covid.each do |c|
    #   if c.properties['Reporting_PHU_City'].eql?("Toronto") && c.properties['Outcome1'].eql?('Not Resolved')
    #     toronto_cases << c
    #   end
    # end
    #
    #
    # def match_city(city_string)
    #   geo_object.properties['Reporting_PHU_City'].eql?("Toronto")
    # end

    # city_hash["Toronto"] = city_hash["Toronto"] + toronto_cases.count
    #
    # puts 'after adding total cases to Toronto'
    # puts city_hash["Toronto"]


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


    # this is where you are:
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
      city_hash = Hash.new
      # for each unique city from @covid dataset, set its value to 0 in the hash
      unique_cities = @covid.uniq {|covid| covid.properties['Reporting_PHU_City'] }

      unique_cities.each do |city_name|
        name_string = city_name.properties['Reporting_PHU_City']
        city_hash[name_string] = find_case_count(name_string)
      end


      puts city_hash
      # puts 'after setting city hash key values to method to count case totals'
      # puts city_hash["Toronto"]
      # puts city_hash["Oakville"]
      # puts city_hash["Newmarket"]
      # puts city_hash["London"]
