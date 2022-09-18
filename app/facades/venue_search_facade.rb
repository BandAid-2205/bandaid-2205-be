class VenueSearchFacade 
    def self.venue_search(venue, location) 
        venue_json = VenueService.search_venue(venue, location)
        
        if venue_json[:error]
            
            return venue_json
        else 
            venue_json[:businesses].map do |business|
                VenuePoro.new(business)
            end 
        end  
    end 
end 