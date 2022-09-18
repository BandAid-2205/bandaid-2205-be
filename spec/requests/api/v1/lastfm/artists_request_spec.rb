require 'rails_helper'

RSpec.describe 'Artist Search API' do 
  describe 'LastFM artist search by name' do 
    it 'sends a single Artist based on a query to the LastFM API', :vcr do
      # 1. make a GET request to our own Artists API 
      # 2. in the controller, pull from LastFM API and return ArtistPoro objects 
      # 3. serialize the ArtistPoro objects 

      get '/api/v1/lastfm/search?query=the%20dirty%20dozen%20brass%20band'

      expect(response).to be_successful 

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)

      artist_data = json[:data]

      expect(artist_data).to have_key(:type)
      expect(artist_data[:type]).to eq "artist_poro"

      expect(artist_data[:attributes]).to have_key(:name)
      expect(artist_data[:attributes][:name]).to eq 'The Dirty Dozen Brass Band'

      expect(artist_data[:attributes]).to have_key(:bio)
      expect(artist_data[:attributes][:bio]).to eq "The Dirty Dozen Brass Band are a New Orleans style brass band which plays R&B and Traditional New Orleans music. Band Members include Charles Joseph, Keith Anderson, Roger Lewis, Kevin Harris, Lionel Batiste, Efrem Towns, Kirk Joseph, Jenell Marshall, Revert Andrews, Gregory Davis, and Raymond Weber. Original band formed in 1975.\n\nThe Dirty Dozen Brass Band \n\nCelebrating over 40 years since their founding in 1977, New Orleans-based Dirty Dozen Brass <a href=\"https://www.last.fm/music/The+Dirty+Dozen+Brass+Band\">Read more on Last.fm</a>"

      expect(artist_data[:attributes]).to have_key(:genres)
      expect(artist_data[:attributes][:genres]).to include('jazz', 'New Orleans', 'brass', 'funk')

      expect(artist_data[:attributes]).to have_key(:image_path)
      expect(artist_data[:attributes][:image_path]).to eq 'https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png'

      # artist = Artist.create!(name: 'The Dirty Dozen Brass Band', location: 'New Orleans', bio: 'The Dirty Dozen Brass Band are a New Orleans style brass band which plays R&B and Traditional New Orleans music. Band Members include Charles Joseph, Keith Anderson, Roger Lewis, Kevin Harris, Lionel Batiste, Efrem Towns, Kirk Joseph, Jenell Marshall, Revert Andrews, Gregory Davis, and Raymond Weber. Original band formed in 1975.', genres: ['jazz', 'New Orleans', 'brass', 'funk'], image_path: "https://lastfm.freetls.fastly.net/i/u/174s/2a96cbd8b46e442fc41c2b86b821562f.png", user_id: 1)
    end
    
    it 'returns an error code if the artist does not exist in LastFM API', :vcr do 
      get '/api/v1/lastfm/search?query=jfdksl'

      expect(response).to have_http_status(404)
      expect(response.body).to include("The artist you supplied could not be found")
    end
  end
end
