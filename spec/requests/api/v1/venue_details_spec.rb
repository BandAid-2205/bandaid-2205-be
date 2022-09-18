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
  end
end
