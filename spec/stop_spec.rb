require 'spec_helper'

describe Muni::Stop do
  use_vcr_cassette
  context '#predictions' do
    it 'fetches predictions' do
      route = Muni::Route.find("38")
      route.inbound.stops.first.predictions.should_not be_nil
      prediction = route.inbound.stops.first.predictions.first
      prediction.epochTime.to_i.should be > 0
    end

    it 'should return an empty array if there are no predictions' do
      Muni::Stop.stub(:fetch) { nil }
      route = Muni::Route.find("38")
      route.inbound.stops.first.predictions.should == []
   end

   it 'should return an empty array if there is no direction or predictions' do
      route = Muni::Route.find("38BX")
      route.outbound.stops.first.predictions.should == []    
   end

  end
end