class VenueService 
    def self.conn
        Faraday.new("https://api.yelp.com/v3/") do |faraday| 
            faraday.headers['Authorization'] = ENV['yelp_api_key']
        end 
    end 

    def self.search_venue(music_venue, location)
        response = conn.get("businesses/search?term=#{music_venue}&location=#{location}&limit=5")
        json = JSON.parse(response.body, symbolize_names: true) if response.status == 200 
    end 
end 