require 'sinatra'
require 'json'
require 'cdnio'

module CDNio 
  class WebApp < Sinatra::Application
    set :cdn, CDN.new

    get '/', :provides => :json do
      settings.cdn.libraries(params.include?(:provider) ? params[:provider] : :all).to_json
    end

    get '/latest/:library', :provides => :json do
      library = params[:library]
      provider = params.include?('provider') ? params['provider'] : :all

      latest = settings.cdn.latest(library, provider)

      halt 404, {:error => "Couldn't find #{library} #{provider == :all ? 'at all' : %{in #{provider}}}."}.to_json if latest.nil?

      latest.to_json
    end

    # Start the server if ruby file executed directly
    run! if app_file == $0
  end # WebApp
# CDNio
end
