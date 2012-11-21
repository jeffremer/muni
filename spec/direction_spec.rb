require 'spec_helper'

describe Muni::Direction do
  use_vcr_cassette

  before do
    @route = Muni::Route.find(21)
  end

  context "#stop_at" do
    context "given  a stop tag" do
      before do
        @stop = @route.inbound.stop_at("36497")
      end

      it "should return the corresponding stop" do
        @stop.should be_present
        @stop.title.should == "Steuart St & Mission St"
      end
    end

    context "given a stop title" do
      before do
        @stop  = @route.inbound.stop_at("Hayes St & Shrader St")
      end

      it "should return corresponding stop" do
        @stop.should be_present
        @stop.title.should == "Hayes St & Shrader St"
      end
    end
  end
end