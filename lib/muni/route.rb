require 'rexml/document'
require 'net/http'

module Muni
  class Stop < Base; end
  class Direction < Base; end
  class Route < Base
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
          url = build_url(:routeList)
          xml = Net::HTTP.get(URI.parse(url))
          document = REXML::Document.new(xml)
          routes = []
          document.elements.each('body/route') do |el|
            routes << Route.new({
              :tag => el.attributes['tag'],
              :title => el.attributes['title'],
            })
          end
          routes
        end
        
        def find_by_tag(tag)
          url = build_url(:routeConfig, {:r => tag})
          xml = Net::HTTP.get(URI.parse(url))
          document = REXML::Document.new(xml)
          
          route = Route.new()
          
          document.elements.each('body/route') do |el|           
            route.tag = el.attributes['tag']
            route.title = el.attributes['title']
          end
          
          stops = {}
          
          document.elements.each('body/route/stop') do |stop|
            st = Stop.new({
              :tag => stop.attributes['tag'],
              :title => stop.attributes['title'],
              :lat => stop.attributes['lat'],
              :lon => stop.attributes['lat'],
              :stopId => stop.attributes['lat'],                            
            })
            stops[st[:tag]] = st
          end
          
          route.stops = stops
          
          directions = []
          document.elements.each('body/route/direction') do |direction|
            direction_stops = {}
            direction.elements.each('stop') do |stop|
              direction_stops[stop.attributes['tag']] = stops[stop.attributes['tag']]
            end

            directions << Direction.new({
                :id => direction.attributes['tag'],
                :name => direction.attributes['title'],
                :stops => direction_stops
            })
          end
          route.directions = directions
          
          route
        end
    end
  end
end