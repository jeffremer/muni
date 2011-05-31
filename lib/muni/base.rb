require 'mash'
module Muni
  class NextBusError < StandardError; end
  class Base < Mash
    class << self
      private
        def fetch(command, options = nil)
          url = build_url(command, options)
          xml = Net::HTTP.get(URI.parse(url))
          doc = XmlSimple.xml_in(xml)
          fail NextBusError, doc['Error'].first['content'].gsub(/\n/,'') if doc['Error']
          doc
        end
      
        def build_url(command, options = nil)
          url = "http://webservices.nextbus.com/service/publicXMLFeed?command=%s&a=sf-muni" %  command
          if options
            options.each { |key,value|
              url << "&#{key}=#{value}"
            }
          end
          url
        end
        
    end
  end
end
