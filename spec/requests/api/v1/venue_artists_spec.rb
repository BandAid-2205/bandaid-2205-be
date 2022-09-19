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

      post "/api/v1/venue_artists", headers: headers, params: JSON.generate(venue_artists: va_params)

      created_venue_artist = VenueArtist.last 

      expect(response).to be_successful
      expect(created_venue_artist.venue_id).to eq va_params[:venue_id]
      expect(created_venue_artist.artist_id).to eq va_params[:artist_id]
      expect(created_venue_artist.booking_status).to eq 'pending'
    end

    it 'returns an error if creation is unsuccessful' do 
      va_params = ({ 
        venue_id: '', 
        artist_id: '', 
      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venue_artists", headers: headers, params: JSON.generate(venue_artists: va_params)

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Venue can't be blank, Artist can't be blank, Venue must exist, Artist must exist")
    end
  end
end