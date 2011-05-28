require 'mash'
module Muni
  class Base < Mash
    class << self
      def find(id)
                
      end
      
      
      private
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
