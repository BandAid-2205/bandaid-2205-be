require 'rails_helper'

RSpec.describe BusinessSearchService do 
    describe 'Business Search Service' do 
      context "#search_venue(music_venue, location)" do 
            it 'can search for different music venues by search term and location' do 
                music_venue = BusinessSearchService.search_venue("music venue", "New Orleans")

                expect(music_venue).to be_a(Hash)
                expect(music_venue).to have_key(:businesses)

                music_venue_info = music_venue[:businesses].first

                expect(music_venue_info).to have_key(:name)
                expect(music_venue_info[:name]).to be_a(String)

                expect(music_venue_info).to have_key(:rating)
                expect(music_venue_info[:rating]).to be_a(Float)
                
                expect(music_venue_info).to have_key(:location)
                expect(music_venue_info[:location]).to be_a(Hash)
                expect(music_venue_info[:location][:city]).to be_a(String)
                expect(music_venue_info[:location][:zip_code]).to be_a(String)
                expect(music_venue_info[:location][:country]).to be_a(String)
                expect(music_venue_info[:location][:state]).to be_a(String)
                expect(music_venue_info[:location][:display_address]).to be_a(Array)
                expect(music_venue_info[:location][:display_address].first).to be_a(String)
                expect(music_venue_info[:location][:display_address].last).to be_a(String)
            end 
        end 
    end 
end 