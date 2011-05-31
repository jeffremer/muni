require 'amatch'

module Muni
  class Direction < Base
    def stop_at(place)
      pattern = Amatch::Sellers.new(place) 
      stops.sort_by{ |stop|
        pattern.match(stop.title)
      }.first
    end
  end
end    