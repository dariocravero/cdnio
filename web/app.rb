require 'sinatra'
require 'haml'
require 'json'
require 'cdnio'
require 'moneta'

module CDNio 
  class WebApp < Sinatra::Application
    set :cdn, CDN.new
    set :layout, :layout
    set :haml, :format => :html5, :ugly => ENV['RACK_ENV'] == 'production'
    set :cache, Moneta.new(:Memory)

    def cached(key)
      settings.cache[key] = yield unless settings.cache.key?(key)
      settings.cache[key]
    end

    get '/', :provides => [:json, :html] do
      if content_type =~ /json/
        cached(provider = params.include?('provider') ? params['provider'] : :all) do
          settings.cdn.libraries(provider).to_json
        end
      elsif content_type =~ /html/
        cached(:index) do
          haml :index
        end
      end
    end

    get '/latest/:library', :provides => [:json, :html] do
      if content_type =~ /json/
        provider = params.include?('provider') ? params['provider'] : :all
        library = params[:library]

        cached("#{provider}_#{library}") do
          settings.cdn.latest(library, provider).to_json
        end
      elsif content_type =~ /html/
        cached(:latest) do
          haml :latest
        end
      end
    end

    # Start the server if ruby file executed directly
    run! if app_file == $0
  end # WebApp
# CDNio
end
