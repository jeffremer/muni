require 'muni/base'
require 'muni/route'

describe "Muni::Stop" do
  it "#times fetches predictions" do   
    route = Muni::Route.find(21)
    direction = route.directions.first
    stop = direction.stops.first
    times = stop.predictions
    times.each do |time|
      p time.pretty_time
    end        
  end
end