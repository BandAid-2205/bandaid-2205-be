require 'rails_helper' 

RSpec.describe 'Venue Details' do 
  it 'creates a new set of Venue details tied to a User' do 
    venue_1 = create(:venue)

    venue_params = ({
                      name: venue_1.name, 
                      location: venue_1.location, 
                      phone: venue_1.phone, 
                      price: venue_1.price, 
                      category: venue_1.category, 
                      rating: venue_1.rating, 
                      user_id: venue_1.user_id
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
end