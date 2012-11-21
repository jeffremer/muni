require 'spec_helper'

describe Muni::Route do
  use_vcr_cassette

  it "fetches all available routes" do
    routes = Muni::Route.find(:all)
    routes.should_not be_empty
    routes.first.tag.should == "F"
  end

  it "fetches routes by tag" do
    Muni::Route.find(21).tag.should == "21"
  end
end