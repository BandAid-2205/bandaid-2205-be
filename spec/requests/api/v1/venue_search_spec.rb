require 'rails_helper'

RSpec.describe 'Venue Search' do
  it 'can find all Venues by location case insensitive' do
    create_list(:venue, 10)
    venue1 = Venue.first

    get "/api/v1/venues/find_all?location=#{venue1.location.downcase}"

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

  it 'returns 400 if no Venue matches search by location' do
    create_list(:venue, 5)

    search_location = 'jdfsnfhe'

    get "/api/v1/venues/find_all?location=#{search_location}"

    expect(response).to_not be_successful
  end

  it 'returns 404 if search by location is empty' do
    create_list(:venue, 5)

    search_location = ''

    get "/api/v1/venues/find_all?location=#{search_location}"

    expect(response).to_not be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    venue = response_body[:data]

    expect(venue).to eq({})
  end
end
