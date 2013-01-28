module CDNio
  module Providers
    class Google < Base 
      URL = 'https://developers.google.com/speed/libraries/devguide' 

      private
        def fetch
          require 'nokogiri'
          require 'open-uri'
          doc = Nokogiri::HTML(open(URL))

          @libraries = doc.css('table dl dd a').map do |library_link|
            libDiv = doc.css(library_link[:href])

            {:name => library_link[:href].gsub('#', ''),
             :latest_version => libDiv.at_css('span.versions').text.split(', ').first,
             :url => Nokogiri::HTML(libDiv.at_css('code.snippet').text).at_css('script')[:src]}
          end
          self
        end
    end # Google
  end # Providers
end # CDNio
