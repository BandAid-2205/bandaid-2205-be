require 'rails_helper'

RSpec.describe 'Venue Search API' do 
    describe 'yelp search by venue name & location' do 
        it 'sends a single venue based on a query to the Yelp Api', :vcr do 
            
            get '/api/v1/yelp/search?term=music%20venue&location=New%20Orleans&limit=5'

            expect(response).to be_successful

            json = JSON.parse(response.body, symbolize_names: true)

            expect(json).to be_a(Hash)

            venue_data = json[:data]    
            # binding.pry
            expect(venue_data.first).to have_key(:type)
            expect(venue_data.first[:type]).to eq("venue_poro")

            expect(venue_data.first[:attributes]).to have_key(:name)
            expect(venue_data.first[:attributes][:name]).to eq("The Spotted Cat Music Club")

            expect(venue_data.first[:attributes]).to have_key(:rating)
            expect(venue_data.first[:attributes][:rating]).to eq(4.5)

            expect(venue_data.first[:attributes]).to have_key(:phone)
            expect(venue_data.first[:attributes][:phone]).to be_a(String)

            expect(venue_data.first[:attributes]).to have_key(:price)
            expect(venue_data.first[:attributes][:location]).to eq("623 Frenchmen St  New Orleans, LA 70116")

            expect(venue_data.first[:attributes]).to have_key(:category)
         
            expect(venue_data.first[:attributes][:category]).to include("Jazz & Blues", "Bars", "Music Venues")
        end 

          it 'returns an error code if the venue does not exist in the Yelp API', :vcr do
            get '/api/v1/yelp/search?term=dfsfsd&location=dfdfs'

            expect(response).to have_http_status(404)
            expect(response.body).to eq("Could not execute search, try specifying a more exact location.")
        end
    end 
end 