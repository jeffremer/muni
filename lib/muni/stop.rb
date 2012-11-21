require 'muni/base'
require 'muni/prediction'

module Muni
  class Stop < Base
    def predictions
      stop = Stop.send(:fetch, :predictions, r: route_tag, d: direction, s: tag)
      return [] unless stop && stop['predictions']
      stop['predictions'].first['direction'].first['prediction'].collect do |pred|
        Prediction.new(pred)
      end
    end
  end
end
