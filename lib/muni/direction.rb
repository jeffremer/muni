module Muni
  class Direction < Base
    def stop_at(place)
      return stops.select{|stop| stop.tag == place}.first if place =~ /[1-9][0-9]+/
      pattern = Amatch::Sellers.new(place)
      stops.sort_by{ |stop|
        pattern.match(stop.title)
      }.first
    end
  end
end