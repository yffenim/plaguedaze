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
