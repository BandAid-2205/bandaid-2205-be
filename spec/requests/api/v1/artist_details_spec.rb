require 'rails_helper'

RSpec.describe 'Artist profile page' do
  describe 'artist CRUD' do
    it "can create a new artist then delete it" do
      artist_params = ({
                      name: Faker::Music.band,
                      location: Faker::Address.full_address,
                      bio: Faker::Lorem.paragraph,
                      genre: Faker::Music.genre,
                      image_path: Faker::LoremPixel.image,
                      user_id: Faker::Number.within(range: 50..75)
                    })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/artists", headers: headers, params: JSON.generate(artist: artist_params)
      created_artist = Artist.last

      expect(response).to be_successful
      expect(response).to have_http_status(201)
      expect(created_artist.name).to eq(artist_params[:name])
      expect(created_artist.location).to eq(artist_params[:location])
      expect(created_artist.bio).to eq(artist_params[:bio])
      expect(created_artist.genre).to eq(artist_params[:genre])
      expect(created_artist.image_path).to eq(artist_params[:image_path])
      expect(created_artist.user_id).to eq(artist_params[:user_id])

      delete "/api/v1/artists/#{created_artist.id}"

      expect(response).to have_http_status(204)
      expect(Artist.count).to eq(0)
      expect{Artist.find(created_artist.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns an error if user does not enter correct info' do
      artist_params = ({
                      name: '',
                      location: Faker::Address.full_address,
                      bio: Faker::Lorem.paragraph,
                      genre: Faker::Music.genre,
                      image_path: Faker::LoremPixel.image,
                      user_id: Faker::Number.within(range: 50..75)
                    })

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/artists", headers: headers, params: JSON.generate(artist: artist_params)

      expect(response).to have_http_status(422)
      # expect(response.body).to include("Validation failed: Name can't be blank")
    end

    it "can update an existing artist" do
      id = create(:artist).id
      previous_name = Artist.last.name
      artist_params = { name: Faker::Music.band }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/artists/#{id}", headers: headers, params: JSON.generate({artist: artist_params})
      artist = Artist.find_by(id: id)

      expect(response).to be_successful
      expect(artist.name).to_not eq(previous_name)
      expect(artist.name).to eq(artist_params[:name])
    end
  end
end
