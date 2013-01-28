require 'cdnio/version'
require 'cdnio/providers'

module CDNio 
  class UnsupportedProviderException < Exception; end

  class CDN
    PROVIDERS = [:cdnjs, :google, :microsoft]

    def initialize
      @providers = {}
    end

    def latest(library, provider = :all)
      provider = provider.downcase.to_sym
      raise UnsupportedProviderException, provider unless (PROVIDERS.include?(provider) || provider == :all)

      if provider == :all
        get_missing

        Hash[*PROVIDERS.map do |prov|
          lib = @providers[prov].latest(library)
          [prov, lib] if lib
        end.flatten.compact]
      else
        get_provider(provider) unless @providers.include?(provider)

        @providers[provider].latest(library)
      end
    end

    def libraries(provider = :all)
      provider = provider.to_sym
      raise UnsupportedProviderException, provider unless (PROVIDERS.include?(provider) || provider == :all)
      if provider == :all
        get_missing 

        Hash[*PROVIDERS.map do |prov|
          libraries = @providers[prov].libraries
          [prov, libraries] unless libraries.empty?
        end.flatten(1).compact]
      else
        get_provider(provider)

        @providers[provider].libraries
      end
    end

    private
      def get_missing
        PROVIDERS.map do |provider|
          get_provider(provider) unless @providers.include?(provider)
        end
      end

      def get_provider(provider)
        return if @providers.include?(provider)

        @providers[provider] = CDNio::Providers.const_get(provider.capitalize).new
        @providers[provider].libraries
      end
  end # CDN
end # CDNio
