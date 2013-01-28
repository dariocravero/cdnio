module CDNio
  module Providers
    class Cdnjs < Base 
      URL = 'http://cdnjs.com' 

      private 
        def fetch
          super(URL) do |doc|
            @libraries = doc.css('.packages-table-container tbody tr').map do |library|
              tds = library.css('td')

              {:name => tds.first.at_css('a').text,
               :latest_version => tds[1].at_css('.version h3').text,
               :url => tds[1].xpath('text()').text.strip}
            end
          end
        end
    end # Cdnjs
  end # Providers
end # CDNio
