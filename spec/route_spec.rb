require 'spec_helper'

describe Muni::Route, vcr: true do
  it "fetches all available routes" do
    routes = Muni::Route.find(:all)
    routes.should_not be_empty
    routes.first.tag.should == "F"
  end

  it "fetches routes by tag" do
    Muni::Route.find(21).tag.should == "21"
  end

  it "should have the correct lon and lat" do
    r21 = Muni::Route.find(21)
    r21.inbound.stops.first.lon.should == "-122.46384"
    r21.inbound.stops.first.lat.should == "37.7735299"
  end
end
