require 'sinatra'
require 'json'
require 'cdnio'

module CDNio 
  class WebApp < Sinatra::Application
    set :cdn, CDN.new
    set :layout, :layout
    set :format, :html5

    get '/', :provides => [:json, :html] do
      if content_type =~ /json/
        settings.cdn.libraries(params.include?(:provider) ? params[:provider] : :all).to_json
      elsif content_type =~ /html/
        haml :index
      end
    end

    get '/latest/:library', :provides => [:json, :html] do
      if content_type =~ /json/
        library = params[:library]
        provider = params.include?('provider') ? params['provider'] : :all

        latest = settings.cdn.latest(library, provider)

        halt 404, {:error => "Couldn't find #{library} #{provider == :all ? 'at all' : %{in #{provider}}}."}.to_json if latest.nil?

        latest.to_json
      elsif content_type =~ /html/
        haml :latest
      end
    end

    # Start the server if ruby file executed directly
    run! if app_file == $0
  end # WebApp
# CDNio
end
