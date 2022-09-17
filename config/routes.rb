Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/artists/search', to: 'artists/search#show'
      namespace :lastfm do
        get '/search', to: 'artist_info#find_artist'
      end
    end
  end
end
