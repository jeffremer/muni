require 'muni/base'
require 'muni/route'

describe "Muni::Route" do
  it "fetches all available routes" do   
    Muni::Route.find(:all)
  end
  
  it "fetches routes by tag" do
    Muni::Route.find(21)
  end
end