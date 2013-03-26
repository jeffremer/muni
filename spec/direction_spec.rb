require 'spec_helper'

describe Muni::Direction, vcr: true do
  let(:route) { Muni::Route.find(24) }

  context "#stop_at" do
    context "given a stop tag" do
      it "should return the corresponding stop" do
        stop = route.inbound.stop_at("3520")

        stop.should be_present
        stop.title.should == "26th St & Noe St"
      end
    end

    context "given an exact stop title" do
      it "should return corresponding stop" do
        stop = route.inbound.stop_at("26th St & Noe St")

        stop.should be_present
        stop.title.should == "26th St & Noe St"
      end
    end

    context "given an inexact stop title" do
      it "should return a corresponding stop" do
        stop = route.inbound.stop_at("26th & Noe")
        stop.should be_present
        stop.title.should == "26th St & Noe St"
        stop.tag.should == "3520"
      end
    end
  end
end
