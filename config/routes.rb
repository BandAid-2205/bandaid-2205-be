Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/artists/search', to: 'artists/search#show'
      get '/venues/search', to: 'venues/search#show'
      namespace :lastfm do
        get '/search', to: 'artist_info#find_artist'
      end
      namespace :yelp do 
        get '/search', to: 'venue_info#find_venue'
      end 
    end
  end
end
