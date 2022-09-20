require 'rails_helper' 

RSpec.describe VenueArtist do 
  describe 'Create VenueArtist' do 
    it 'creates a new VenueArtist tied to a Venue and an Artist' do 
      venue_1 = create(:venue)
      artist_1 = create(:artist)

      va_params = ({ 
        venue_id: venue_1.user_id, 
        artist_id: artist_1.user_id, 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues/#{venue_1.user_id}/venue_artists/#{artist_1.user_id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      created_venue_artist = VenueArtist.last 

      expect(response).to be_successful
      expect(created_venue_artist.venue_id).to eq venue_1.id
      expect(created_venue_artist.artist_id).to eq artist_1.id
      expect(created_venue_artist.booking_status).to eq 'pending'
    end

    it 'returns an error if creation is unsuccessful' do 
      venue_1 = create(:venue)
      artist_1 = create(:artist)
      
      va_params = ({ 
        venue_id: '', 
        artist_id: '', 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues/#{venue_1.user_id}/venue_artists/#{artist_1.user_id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      expect(response).to have_http_status(404)
      expect(response.body).to include("Couldn't find Venue")
    end
  end

  describe 'Edit VenueArtist' do 
    it 'can update the enum from pending to accepted' do 
      venue_1 = create(:venue)
      artist_1 = create(:artist)

      va_params = ({ 
        venue_id: venue_1.user_id, 
        artist_id: artist_1.user_id, 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues/#{venue_1.user_id}/venue_artists/#{artist_1.user_id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      venue_artist = VenueArtist.last
      
      update_params = ({
        booking_status: 1
      })
      patch "/api/v1/venues/#{venue_1.user_id}/venue_artists/#{artist_1.user_id}", headers: headers, params: JSON.generate({ venue_artist: update_params})

      expect(response).to be_successful
      expect(venue_artist.reload.booking_status).to_not eq 'pending'
      expect(venue_artist.reload.booking_status).to eq 'accepted'
    end

    it 'returns an error if update is done incorreclty' do 
      venue_1 = create(:venue)
      artist_1 = create(:artist)

      va_params = ({ 
        venue_id: venue_1.user_id, 
        artist_id: artist_1.user_id, 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues/#{venue_1.user_id}/venue_artists/#{artist_1.user_id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      venue_artist = VenueArtist.last
      
      update_params = ({
        booking_status: 5
      })
      patch "/api/v1/venues/#{venue_1.user_id}/venue_artists/#{artist_1.user_id}", headers: headers, params: JSON.generate({ venue_artist: update_params})

      expect(response).to have_http_status(422)
      expect(response.body).to include("'5' is not a valid booking_status")
    end
  end

  describe 'get VenueArtist' do 
    it 'can return data on a single VenueArtist' do 
      venue_1 = create(:venue)
      artist_1 = create(:artist)

      va_params = ({ 
        venue_id: venue_1.user_id, 
        artist_id: artist_1.user_id, 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues/#{venue_1.user_id}/venue_artists/#{artist_1.user_id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      va = VenueArtist.last

      get "/api/v1/venues/#{venue_1.user_id}/venue_artists/#{artist_1.user_id}"

      expect(response).to be_successful

      va_details = JSON.parse(response.body, symbolize_names: true)

      expect(va_details[:data][:id]).to eq va.id.to_s

      va_data = va_details[:data][:attributes]

      expect(va_data[:venue_id]).to eq va.venue_id
      expect(va_data[:artist_id]).to eq va.artist_id
      expect(va_data[:booking_status]).to eq va.booking_status
    end

    it 'returns an error if data does not exist' do 
      va = create(:venue_artist)

      venue = Venue.create!(name: 'Trilly', location: 'New Orleans', phone: '3333333', price: '$', category: 'food', user_id: va.venue_id)

      get "/api/v1/venues/#{venue.user_id}/venue_artists/abc123"

      expect(response).to have_http_status(404)
      expect(response.body).to include("Couldn't find Artist")
    end 
  end
end