require 'rails_helper'

RSpec.describe 'Artist profile page' do
  describe 'artist creation and deletion after creating' do
    it "can create a new artist then delete it" do
      artist_params = ({
                      name: Faker::Music.band,
                      location: Faker::Address.full_address,
                      bio: Faker::Lorem.paragraph,
                      genre: Faker::Music.genre,
                      image_path: Faker::Placeholdit.image,
                      user_id: Faker::Number.within(range: 50..75)
                    })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/artists", headers: headers, params: JSON.generate(artist: artist_params)
      created_artist = Artist.last

      expect(response).to be_successful
      expect(created_artist.name).to eq(artist_params[:name])
      expect(created_artist.location).to eq(artist_params[:location])
      expect(created_artist.bio).to eq(artist_params[:bio])
      expect(created_artist.genre).to eq(artist_params[:genre])
      expect(created_artist.image_path).to eq(artist_params[:image_path])
      expect(created_artist.user_id).to eq(artist_params[:user_id])

      delete "/api/v1/artists/#{created_artist.user_id}"

      expect(response).to have_http_status(204)
      expect(Artist.count).to eq(0)
      expect{Artist.find(created_artist.user_id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns an error if user does not enter correct info when creating' do
      artist_params = ({
                      name: '',
                      location: Faker::Address.full_address,
                      bio: Faker::Lorem.paragraph,
                      genre: Faker::Music.genre,
                      image_path: Faker::Placeholdit.image,
                      user_id: Faker::Number.within(range: 50..75)
                    })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/artists", headers: headers, params: JSON.generate(artist: artist_params)

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Name can't be blank")
    end

    it 'can destroy an Artist that has VenueArtists' do
      venue_1 = create(:venue)
      venue_2 = create(:venue)
      artist_1 = create(:artist)

      va_1 = VenueArtist.create!(venue_id: venue_1.id, artist_id: artist_1.id)
      va_2 = VenueArtist.create!(venue_id: venue_2.id, artist_id: artist_1.id)

      delete "/api/v1/artists/#{artist_1.user_id}"

      expect(response).to be_successful
      expect(Artist.count).to eq 0
      expect(VenueArtist.count).to eq 0
      expect{ Artist.find(artist_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Venue.find(va_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Venue.find(va_2.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'Artist update' do
    it "can update an existing artist" do
      artist1 = create(:artist)
      previous_name = artist1.name
      artist_params = { name: Faker::Music.band }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/artists/#{artist1.user_id}", headers: headers, params: JSON.generate({artist: artist_params})
      artist = Artist.find_by(user_id: artist1.user_id)

      expect(response).to be_successful
      expect(artist.name).to_not eq(previous_name)
      expect(artist.name).to eq(artist_params[:name])
    end

    it 'can update multiple Artist details at once' do
      artist1 = create(:artist)

      previous_name = artist1.name
      previous_bio = artist1.bio
      previous_genre = artist1.genre

      artist_params = { name: Faker::Music.band, bio: Faker::Lorem.paragraph, genre: 'new genre' }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/artists/#{artist1.user_id}", headers: headers, params: JSON.generate({artist: artist_params})
      artist = Artist.find_by(user_id: artist1.user_id)

      expect(response).to be_successful
      expect(artist.name).to_not eq(previous_name)
      expect(artist.name).to eq(artist_params[:name])
      expect(artist.bio).to_not eq(previous_bio)
      expect(artist.bio).to eq(artist_params[:bio])
      expect(artist.genre).to_not eq(previous_genre)
      expect(artist.genre).to eq(artist_params[:genre])
      expect(artist.genre).to eq('new genre')
    end

    it 'returns error if Artist data does not exist' do
      artist_params = { name: Faker::Music.band, genre: Faker::Music.genre }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/artists/abc123", headers: headers, params: JSON.generate({artist: artist_params})

      expect(response).to have_http_status(404)
      expect(response.body).to include("Couldn't find Artist")
    end

    it 'returns an error if input field is empty' do
      artist1 = create(:artist)

      artist_params = { location: Faker::Address.full_address, bio: '',}
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/artists/#{artist1.user_id}", headers: headers, params: JSON.generate({artist: artist_params})

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Bio can't be blank")
    end
  end

  describe 'Artist show' do
    it 'can retrieve details of a single Artist by userID' do
      artist1 = create(:artist)

      get "/api/v1/artists/#{artist1.user_id}"

      expect(response).to be_successful

      artist_details = JSON.parse(response.body, symbolize_names: true)
      artist = artist_details[:data]

      expect(artist[:id]).to eq(artist1.id.to_s)
      expect(artist[:type]).to eq('artist')
      expect(artist[:attributes][:name]).to eq(artist1.name)
      expect(artist[:attributes][:location]).to eq(artist1.location)
      expect(artist[:attributes][:bio]).to eq(artist1.bio)
      expect(artist[:attributes][:genre]).to eq(artist1.genre)
      expect(artist[:attributes][:image_path]).to eq(artist1.image_path)
      expect(artist[:attributes][:user_id]).to eq(artist1.user_id)
    end

    it 'returns an error if Artist cannot be found' do
      get "/api/v1/artists/abc123"

      expect(response).to have_http_status(404)
      expect(response.body).to include("Couldn't find Artist")
    end

    it 'can the Artists venues and booking_status through the serializer' do
      artists = create_list(:artist, 2)
      artist1 = Artist.first
      artist2 = Artist.second
      venues = create_list(:venue, 4)
      venue1 = Venue.first
      venue2 = Venue.second
      venue3 = Venue.third
      venue4 = Venue.fourth
      v1a1 = VenueArtist.create!(
        artist_id: artist1.id,
        venue_id: venue1.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v2a1 = VenueArtist.create!(
        artist_id: artist1.id,
        venue_id: venue2.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v3a1 = VenueArtist.create!(
        artist_id: artist1.id,
        venue_id: venue3.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v2a2 = VenueArtist.create!(
        artist_id: artist2.id,
        venue_id: venue2.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v4a2 = VenueArtist.create!(
        artist_id: artist2.id,
        venue_id: venue4.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )

      get "/api/v1/artists/#{artist1.user_id}"

      expect(response).to be_successful

      artist_details = JSON.parse(response.body, symbolize_names: true)
      artist = artist_details[:data]

      expect(artist[:id]).to eq(artist1.id.to_s)
      expect(artist[:type]).to eq('artist')
      expect(artist[:attributes][:name]).to eq(artist1.name)
      expect(artist[:attributes][:location]).to eq(artist1.location)
      expect(artist[:attributes][:bio]).to eq(artist1.bio)
      expect(artist[:attributes][:genre]).to eq(artist1.genre)
      expect(artist[:attributes][:image_path]).to eq(artist1.image_path)
      expect(artist[:attributes][:user_id]).to eq(artist1.user_id)
      expect(artist[:attributes][:bookings]).to be_an Array
      expect(artist[:attributes][:bookings].count).to eq 3
      artist[:attributes][:bookings].each do |booking|
        expect(booking).to have_key(:id)
        expect(booking).to have_key(:venue_name)
        expect(booking).to have_key(:booking_status)
        expect(booking[:venue_name]).to_not eq(venue4.name)
      end
      expect(artist[:attributes][:venues].count).to eq 3
      expect(artist[:attributes][:venues][0][:name]).to eq(venue1.name)
      expect(artist[:attributes][:venues][1][:name]).to eq(venue2.name)
      expect(artist[:attributes][:venues][2][:name]).to eq(venue3.name)
      expect(artist[:attributes][:venue_artists][0][:booking_status]).to eq(v1a1.booking_status)
      expect(artist[:attributes][:venue_artists][1][:booking_status]).to eq(v2a1.booking_status)
      expect(artist[:attributes][:venue_artists][2][:booking_status]).to eq(v3a1.booking_status)
    end
  end
end
