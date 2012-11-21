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

  context "when not predictions are available" do
    it "should return an empty array" do
      route     = Muni::Route.find(38)
      stop      = route.outbound.stops[-6]
      
      stop.predictions.should == []
    end
  end

end