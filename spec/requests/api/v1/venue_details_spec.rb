require 'rails_helper'

RSpec.describe 'Venue Details' do

  describe 'Venue Details Create' do
    it 'creates a new set of Venue details tied to a User' do
      venue_params = ({
                        name: Faker::Company.name,
                        location: Faker::Address.full_address,
                        phone: Faker::PhoneNumber.cell_phone,
                        price: ['$', '$$', '$$$', '$$$$'].sample,
                        category: Faker::Company.industry,
                        rating: Faker::Number.within(range: 1..5),
                        user_id: Faker::Number.within(range: 50..75)
                      })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues", headers: headers, params: JSON.generate(venue: venue_params)

      created_venue = Venue.last

      expect(response).to be_successful
      expect(created_venue.name).to eq(venue_params[:name])
      expect(created_venue.location).to eq(venue_params[:location])
      expect(created_venue.phone).to eq(venue_params[:phone])
      expect(created_venue.price).to eq(venue_params[:price])
      expect(created_venue.category).to eq(venue_params[:category])
      expect(created_venue.rating).to eq(venue_params[:rating])
      expect(created_venue.user_id).to eq(venue_params[:user_id])
    end

    it 'returns an error if user does not enter correct info' do
      venue_params = ({
                        name: '',
                        location: Faker::Address.full_address,
                        phone: Faker::PhoneNumber.cell_phone,
                        price: ['$', '$$', '$$$', '$$$$'].sample,
                        category: Faker::Company.industry,
                        rating: Faker::Number.within(range: 1..5),
                        user_id: Faker::Number.within(range: 50..75)
                      })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/venues", headers: headers, params: JSON.generate(venue: venue_params)

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Name can't be blank")
    end
  end

  describe 'Venue Details Get' do
    it 'can retrieve the details of a single Venue by its user_id' do
      venue_1 = create(:venue)

      get "/api/v1/venues/#{venue_1.user_id}"

      expect(response).to be_successful

      venue_details = JSON.parse(response.body, symbolize_names: true)

      venue = venue_details[:data]

      expect(venue[:id]).to eq(venue_1.id.to_s)
      expect(venue[:type]).to eq('venue')
      expect(venue[:attributes][:name]).to eq(venue_1.name)
      expect(venue[:attributes][:location]).to eq(venue_1.location)
      expect(venue[:attributes][:phone]).to eq(venue_1.phone)
      expect(venue[:attributes][:price]).to eq(venue_1.price)
      expect(venue[:attributes][:category]).to eq(venue_1.category)
      expect(venue[:attributes][:rating]).to eq(venue_1.rating)
      expect(venue[:attributes][:user_id]).to eq(venue_1.user_id)
    end

    it 'returns an error if venue does not exist' do
      get "/api/v1/venues/abc123"

      expect(response).to have_http_status(404)
      expect(response.body).to include("Couldn't find Venue")
    end

    it 'can retrieve nested details of Artist and VenueArtist when joined' do
      venues = create_list(:venue, 2)
      venue1 = Venue.first
      venue2 = Venue.second
      artists = create_list(:artist, 3)
      artist1 = Artist.first
      artist2 = Artist.second
      artist3 = Artist.third
      v1a1 = VenueArtist.create!(
        venue_id: venue1.id,
        artist_id: artist1.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v1a2 = VenueArtist.create!(
        venue_id: venue1.id,
        artist_id: artist2.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v2a3 = VenueArtist.create!(
        venue_id: venue2.id,
        artist_id: artist3.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )

      get "/api/v1/venues/#{venue1.user_id}"

      expect(response).to be_successful

      venue_details = JSON.parse(response.body, symbolize_names: true)

      venue = venue_details[:data]

      expect(venue[:id]).to eq(venue1.id.to_s)
      expect(venue[:type]).to eq('venue')
      expect(venue[:attributes][:name]).to eq(venue1.name)
      expect(venue[:attributes][:location]).to eq(venue1.location)
      expect(venue[:attributes][:phone]).to eq(venue1.phone)
      expect(venue[:attributes][:price]).to eq(venue1.price)
      expect(venue[:attributes][:category]).to eq(venue1.category)
      expect(venue[:attributes][:rating]).to eq(venue1.rating)
      expect(venue[:attributes][:user_id]).to eq(venue1.user_id)
      expect(venue[:attributes][:bookings]).to be_an Array
      expect(venue[:attributes][:bookings].count).to eq 2
      venue[:attributes][:bookings].each do |booking|
        expect(booking).to have_key(:id)
        expect(booking).to have_key(:artist_name)
        expect(booking).to have_key(:booking_status)
        expect(booking[:artist_name]).to_not eq(artist3.name)
      end
      expect(venue[:attributes][:artists].count).to eq(2)
      expect(venue[:attributes][:artists][0][:name]).to eq(artist1.name)
      expect(venue[:attributes][:artists][1][:name]).to eq(artist2.name)
      expect(venue[:attributes][:venue_artists][0][:booking_status]).to eq(v1a1.booking_status)
      expect(venue[:attributes][:venue_artists][1][:booking_status]).to eq(v1a2.booking_status)
    end
  end

  describe 'Venue Details Update' do
    it 'can update an existing Venues details' do
      venue_1 = create(:venue)

      old_phone = venue_1.phone

      venue_params = { phone: "504-555-555" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/venues/#{venue_1.user_id}", headers: headers, params: JSON.generate({venue: venue_params})

      updated_venue = Venue.find_by(user_id: venue_1.user_id)

      expect(response).to be_successful

      expect(updated_venue.phone).to_not eq old_phone
      expect(updated_venue.phone).to eq "504-555-555"
    end

    it 'can update multiple existing Venues details' do
      venue_1 = create(:venue)

      old_phone = venue_1.phone
      old_price = venue_1.price
      old_category = venue_1.category

      venue_params = { phone: "504-555-555", price: '$$$', category: 'new category' }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/venues/#{venue_1.user_id}", headers: headers, params: JSON.generate({venue: venue_params})

      updated_venue = Venue.find_by(user_id: venue_1.user_id)

      expect(response).to be_successful

      expect(updated_venue.phone).to_not eq old_phone
      expect(updated_venue.phone).to eq "504-555-555"

      expect(updated_venue.price).to eq "$$$"

      expect(updated_venue.category).to_not eq old_category
      expect(updated_venue.category).to eq 'new category'
    end

    it 'returns an error if Venue data does not exist' do
      venue_params = { phone: "504-555-555", price: '$$$', category: 'new category' }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/venues/abc123", headers: headers, params: JSON.generate({venue: venue_params})

      expect(response).to have_http_status(404)
      expect(response.body).to include("Couldn't find Venue")
    end

    it 'returns an error if price input is invalid' do
      venue_1 = create(:venue)

      venue_params = { phone: 504555555, price: '', category: 7 }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/venues/#{venue_1.user_id}", headers: headers, params: JSON.generate({venue: venue_params})

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Price is not included in the list")
    end

    it 'returns an error if rating input is invalid' do
      venue_1 = create(:venue)

      venue_params = { phone: 504555555, rating: 'bad rating' }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/venues/#{venue_1.user_id}", headers: headers, params: JSON.generate({venue: venue_params})

      expect(response).to have_http_status(422)
      expect(response.body).to include("Validation failed: Rating is not a number")
    end
  end

  describe 'Venue Details Destroy' do
    it 'can destroy a Venue given user_id' do
      venue_1 = create(:venue)

      expect(Venue.count).to eq 1

      delete "/api/v1/venues/#{venue_1.user_id}"

      expect(response).to be_successful
      expect(Venue.count).to eq 0
      expect{ Venue.find(venue_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns an error if it cannot destroy Venue matching user_id' do
      delete "/api/v1/venues/abc123"

      expect(response).to have_http_status(404)
      expect(response.body).to include("Couldn't find Venue")
    end

    it 'can destroy a Venue that has VenueArtists' do
      venue_1 = create(:venue)
      artist_1 = create(:artist)
      artist_2 = create(:artist)

      va_1 = VenueArtist.create!(venue_id: venue_1.id, artist_id: artist_1.id)
      va_2 = VenueArtist.create!(venue_id: venue_1.id, artist_id: artist_2.id)

      delete "/api/v1/venues/#{venue_1.user_id}"

      expect(response).to be_successful
      expect(Venue.count).to eq 0
      expect(VenueArtist.count).to eq 0
      expect{ Venue.find(venue_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Venue.find(va_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Venue.find(va_2.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'Venue index' do
    it 'returns a list of Venues' do
      create_list(:venue, 5)

      get '/api/v1/venues'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names: true)
      venues = response_body[:data]

      venues.each do |venue|
        expect(venue).to have_key(:id)
        expect(venue[:id]).to be_a(String)

        expect(venue).to have_key(:attributes)
        expect(venue[:attributes][:name]).to be_a(String)
        expect(venue[:attributes][:location]).to be_a(String)
        expect(venue[:attributes][:phone]).to be_a(String)
        expect(venue[:attributes][:price]).to be_a(String)
        expect(venue[:attributes][:category]).to be_a(String)
        expect(venue[:attributes][:rating]).to be_an(Integer)
        expect(venue[:attributes]).to_not have_key(:created_at)
      end
    end
  end
end
