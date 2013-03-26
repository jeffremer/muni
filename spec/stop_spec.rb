require 'spec_helper'

describe Muni::Stop, vcr: true do
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

   it 'should return an empty array if there are no predictions' do
      stop = Muni::Route.find("38").outbound.stops.first
      Muni::Stop.stub(:send) { nil }
      stop.predictions.should == []
   end

  end
end
