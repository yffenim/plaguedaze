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
