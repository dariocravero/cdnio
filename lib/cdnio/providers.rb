module CDNio
  module Providers
    class Base 
      def latest(library)
        fetch unless @libraries
        @libraries.select { |l| l[:name] == library.to_s }.first
      end

      def libraries
        fetch unless @libraries
        @libraries
      end
    end # Base
  end # Providers
end # CDNio

require 'cdnio/providers/cdnjs'
require 'cdnio/providers/google'
require 'cdnio/providers/microsoft'
