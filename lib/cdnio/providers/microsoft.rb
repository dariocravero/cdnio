module CDNio
  module Providers
    class Microsoft < Base 
      URL = 'http://www.asp.net/ajaxlibrary/CDN.ashx' 

      private 
        def fetch
          # TODO Implement
          @libraries = []
          self
        end
    end # Microsoft
  end # Providers
end # CDNio
