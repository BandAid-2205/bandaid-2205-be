Rails.application.routes.draw do
    namespace :api do
    namespace :v1 do
      resources :venues, only: [:create, :show, :update, :destroy] 

      resources :artists, only: [:show, :create, :update, :destroy]
      # resources :venue_artists, only: [:create, :update]

      namespace :lastfm do
        get '/search', to: 'artist_info#find_artist'
      end
      namespace :yelp do
        get '/search', to: 'venue_info#find_venue'
      end
    end
  end

  # VenueArtist CRUD 
  post "api/v1/venues/:id/venue_artists/:artist_id", to: 'venue_artists#create'

  patch "api/v1/venues/:id/venue_artists/:artist_id", to: 'venue_artists#update'
  
  get "api/v1/venues/:id/venue_artists/:artist_id", to: 'venue_artists#show'
end
