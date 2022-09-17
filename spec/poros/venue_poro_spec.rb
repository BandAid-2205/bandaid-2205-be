require 'rails_helper' 

RSpec.describe 'Venue Poro' do 
    it 'exists and has the correct venue attributes' do 
        
        data = {
            "id": "RvTHIKHaPVVp8S9cihpi5w",
            "alias": "the-spotted-cat-music-club-new-orleans",
            "name": "The Spotted Cat Music Club",
            "image_url": "https://s3-media1.fl.yelpcdn.com/bphoto/kcOgu2eDQbJne56DWvJ_qQ/o.jpg",
            "is_closed": false,
            "url": "https://www.yelp.com/biz/the-spotted-cat-music-club-new-orleans?adjust_creative=lEP9cBAeECfg4vQqgY1eNA&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=lEP9cBAeECfg4vQqgY1eNA",
            "review_count": 918,
            "categories": [
                {
                    "alias": "jazzandblues",
                    "title": "Jazz & Blues"
                },
                {
                    "alias": "bars",
                    "title": "Bars"
                },
                {
                    "alias": "musicvenues",
                    "title": "Music Venues"
                }
            ],
            "rating": 4.5,
            "coordinates": {
                "latitude": 29.964090152963,
                "longitude": -90.057709682929
            },
            "transactions": [],
            "price": "$$",
            "location": {
                "address1": "623 Frenchmen St",
                "address2": "",
                "address3": "",
                "city": "New Orleans",
                "zip_code": "70116",
                "country": "US",
                "state": "LA",
                "display_address": [
                    "623 Frenchmen St",
                    "New Orleans, LA 70116"
                ]
            },
            "phone": "",
            "display_phone": "",
            "distance": 2663.776254165871
        }

        venue = VenuePoro.new(data)

        expect(venue).to be_a(VenuePoro)
        expect(venue.id).to eq("RvTHIKHaPVVp8S9cihpi5w")
        expect(venue.name).to eq("The Spotted Cat Music Club")
        expect(venue.rating).to eq(4.5)
        expect(venue.price).to eq("$$")
        expect(venue.category).to eq("Jazz & Blues")
        # expect(venue.address(data[:location]).to eq("623 Frenchmen St  New Orleans, LA 70116")
        expect(venue.location).to eq("623 Frenchmen St  New Orleans, LA 70116")
    end 
end 