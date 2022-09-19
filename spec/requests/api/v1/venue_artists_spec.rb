require 'rails_helper' 

RSpec.describe VenueArtist do 
  describe 'Create VenueArtist' do 
    it 'creates a new VenueArtist tied to a Venue and an Artist' do 
      venue_1 = create(:venue)
      artist_1 = create(:artist)

      va_params = ({ 
        venue_id: venue_1.id, 
        artist_id: artist_1.id, 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues/#{venue_1.id}/venue_artists/#{artist_1.id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      created_venue_artist = VenueArtist.last 

      expect(response).to be_successful
      expect(created_venue_artist.venue_id).to eq va_params[:venue_id]
      expect(created_venue_artist.artist_id).to eq va_params[:artist_id]
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

      post "/api/v1/venues/#{venue_1.id}/venue_artists/#{artist_1.id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Venue can't be blank, Artist can't be blank, Venue must exist, Artist must exist")
    end
  end

  describe 'Edit VenueArtist' do 
    it 'can update the enum from pending to accepted' do 
      venue_1 = create(:venue)
      artist_1 = create(:artist)

      va_params = ({ 
        venue_id: venue_1.id, 
        artist_id: artist_1.id, 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues/#{venue_1.id}/venue_artists/#{artist_1.id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      venue_artist = VenueArtist.last
      
      update_params = ({
        booking_status: 1
      })
      patch "/api/v1/venues/#{venue_1.id}/venue_artists/#{artist_1.id}", headers: headers, params: JSON.generate({ venue_artist: update_params})

      expect(response).to be_successful
      expect(venue_artist.reload.booking_status).to_not eq 'pending'
      expect(venue_artist.reload.booking_status).to eq 'accepted'
    end

    it 'returns an error if update is done incorreclty' do 
      venue_1 = create(:venue)
      artist_1 = create(:artist)

      va_params = ({ 
        venue_id: venue_1.id, 
        artist_id: artist_1.id, 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues/#{venue_1.id}/venue_artists/#{artist_1.id}", headers: headers, params: JSON.generate(venue_artist: va_params)

      venue_artist = VenueArtist.last
      
      update_params = ({
        booking_status: 5
      })
      patch "/api/v1/venues/#{venue_1.id}/venue_artists/#{artist_1.id}", headers: headers, params: JSON.generate({ venue_artist: update_params})

      expect(response).to have_http_status(422)
      expect(response.body).to include("'5' is not a valid booking_status")
    end
  end

  describe 'get VenueArtist' do 
    it 'can return data on a single VenueArtist' do 
      va = create(:venue_artist)

      get "/api/v1/venues/#{va.venue_id}/venue_artists/#{va.artist_id}"

      expect(response).to be_successful

      va_details = JSON.parse(response.body, symbolize_names: true)

      expect(va_details[:data][:id]).to eq va.id.to_s

      va_data = va_details[:data][:attributes]

      expect(va_data[:venue_id]).to eq va.venue_id
      expect(va_data[:artist_id]).to eq va.artist_id
      expect(va_data[:booking_status]).to eq va.booking_status
    end
  end
end