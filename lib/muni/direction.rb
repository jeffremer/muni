require "amatch"

module Muni
  class Direction < Base
    def stop_at(place)
      if stop = stops.detect { |stop| stop.tag == place }
        return stop
      end

      if stop = stops.detect { |stop| stop.title == place }
        return stop
      end

      pattern = Amatch::Sellers.new(place)
      stops.sort_by{ |stop|
        pattern.match(stop.title)
      }.first
    end
  end
end
