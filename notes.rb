covidTO = []
# covid.map do |c|
covidTO = covid.take_while {|c| c.properties['Reporting_PHU_City'].eql?("Toronto") }
  # end
puts covid[0].properties['Reporting_PHU_City']
