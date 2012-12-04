require 'muni/base'
require 'muni/prediction'

module Muni
  class Stop < Base
    def predictions
      stop = Stop.send(:fetch, :predictions, r: route_tag, d: direction, s: tag)
      available_predictions(stop).collect do |pred|
        Prediction.new(pred)
      end
    end

    private

    def available_predictions(stop)
      return [] unless  stop && 
                        stop['predictions'] && 
                        stop['predictions'].first['direction'] &&
                        stop['predictions'].first['direction'].first['prediction']
                        
      stop['predictions'].first['direction'].first['prediction']
    end

  end
end
