module CDNio
  module Providers
    class Cdnjs < Base 
      URL = 'http://cdnjs.com/packages.json' 
      BASE_URL = '//cdnjs.cloudflare.com/ajax/libs'

      private 
        def fetch
          require 'open-uri'
          require 'json'

          @libraries = JSON.parse(open(URL).read)['packages'].map do |package|
            {:name => package['name'],
             :latest_version => package['version'],
             :url => "#{BASE_URL}/#{package['name']}/#{package['version']}/#{package['filename']}"}
          end
          self
        end
    end # Cdnjs
  end # Providers
end # CDNio
