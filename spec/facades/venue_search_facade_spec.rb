require 'rails_helper'

RSpec.describe VenueSearchFacade, :vcr do 

    it 'returns venue attributes for the search venue' do 
       result = VenueSearchFacade.venue_search("The Spotted Cat Music Club", "New Orleans")

       expect(result).to be_an(Array)
       expect(result.first).to be_a(VenuePoro)
       expect(result.first.name).to be_a(String)
       expect(result.first.rating).to be_a(Float)
       expect(result.first.price).to be_a(String)
       expect(result.first.location).to be_a(String)
       expect(result.first.id).to be_a(String)
    end 

    it 'returns an error message if artist is not returned', :vcr do 
        venue_info = VenueSearchFacade.venue_search("dfsfsd", "dfdfs")

        expect(venue_info).to eq({
        "error": {
        "code": "LOCATION_NOT_FOUND",
        "description": "Could not execute search, try specifying a more exact location."
         }
        })
    end
end 