require 'rails_helper' 

RSpec.describe 'Venue Poro' do 
    it 'exists and has the correct venue attributes' do 
        
        venue = VenuePoro.new(name: "The Spotted Cat Music Club", rating: 4.5, price: "$$", location: "623 Frenchmen St New Orleans, LA 70116")

        expect(venue).to be_a(VenuePoro)
        expect(venue.name).to eq("The Spotted Cat Music Club")
        expect(venue.rating).to eq(4.5)
        expect(venue.price).to eq("$$")
        expect(venue.location).to eq("623 Frenchmen St New Orleans, LA 70116")
    end 
end 