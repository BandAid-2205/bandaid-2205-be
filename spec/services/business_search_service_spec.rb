require 'rails_helper'

RSpec.describe BusinessSearchService do 
    describe 'Business Search Service' do 
        
        it 'can search for different music venues by search term and location' do 
            music_venue = BusinessSearchService.search_venue("music venue", "New Orleans")

            expect(music_venue).to be_a(Hash)
        end 
    end 

end 