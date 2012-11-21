require 'spec_helper'

describe Muni::Direction do
  use_vcr_cassette "Muni_Route"

  let(:route) { Muni::Route.find(21) }

  context "#stop_at" do
    context "given  a stop tag" do
      it "should return the corresponding stop" do
        stop = route.inbound.stop_at("36497")

        stop.should be_present
        stop.title.should == "Steuart St & Mission St"
      end
    end

    context "given a stop title" do
      it "should return corresponding stop" do
        stop  = route.inbound.stop_at("Hayes St & Shrader St")

        stop.should be_present
        stop.title.should == "Hayes St & Shrader St"
      end
    end
  end
end