require "ostruct"

module Muni
  class NextBusError < StandardError; end
  class Base < OpenStruct
    class << self
      private

      def fetch(command, options = {})
        url = build_url(command, options)
        xml = Net::HTTP.get(URI.parse(url))
        doc = XmlSimple.xml_in(xml) || {}
        fail NextBusError, doc['Error'].first['content'].gsub(/\n/,'') if doc['Error']
        doc
      end

      def build_url(command, options = {})
        url = "https://retro.umoiq.com/service/publicXMLFeed?command=#{command}&a=sf-muni"
        options.each { |key,value| url << "&#{key}=#{value}" }
        url
      end

    end
  end
end
