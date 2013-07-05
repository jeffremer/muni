require 'net/http'
require 'xmlsimple'

require 'muni/stop'
require 'muni/direction'

module Muni
  class Route < Base
    def direction_at(direction)
      return send(direction.downcase.to_sym) if direction =~ /(outbound|inbound)/i
      directions.select{|dir| dir.id == direction}.first
    end

    def outbound
      directions.select{ |dir| dir.name =~ /outbound/i }.first
    end

    def inbound
      directions.select{ |dir| dir.name =~ /inbound/i }.first
    end

    class << self
      def find(tag)
        if tag == :all
          find_all
        else
          find_by_tag(tag)
        end
      end

      private
        def find_all
          document = fetch(:routeList)
          document['route'].collect do |el|
            Route.new(el)
          end
        end

        def find_by_tag(tag)
          document = fetch(:routeConfig, {:r => tag})
          route = Route.new({:tag => document['route'].first['tag'], :title => document['route'].first['title']})

          stops = {}

          document['route'].first['stop'].each do |stop|
            st = Stop.new({
              :tag => stop['tag'],
              :title => stop['title'],
              :lat => stop['lat'],
              :lon => stop['lon'],
              :stopId => stop['lat'],
            })
            stops[st.tag] = st
          end

          directions = []
          route.directions = document['route'].first['direction'].collect do |direction|
            direction_stops = direction['stop'].collect do |stop|
              stops[stop['tag']]
            end

            direction_stops.each do |stop|
              stop.route_tag = route.tag
              stop.direction = direction['tag']
            end

            Direction.new({
                :id => direction['tag'],
                :name => direction['title'],
                :stops => direction_stops
            })
          end

          route
        end
    end
  end
end
