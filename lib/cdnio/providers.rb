module CDNio
  module Providers
    class Base 
      def latest(library)
        fetch unless @libraries
        @libraries.select { |l| l[:name] == library.to_s }.first
      end

      def libraries
        fetch unless @libraries
        @libraries.collect { |l| l[:name] }
      end

      private 
        def fetch(url)
          return unless block_given?

          require 'nokogiri'
          require 'open-uri'
          yield Nokogiri::HTML(open(url))

          self
        end
    end # Base
  end # Providers
end # CDNio

require 'cdnio/providers/cdnjs'
require 'cdnio/providers/google'
require 'cdnio/providers/microsoft'
