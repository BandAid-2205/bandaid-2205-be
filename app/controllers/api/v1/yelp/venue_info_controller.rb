class Api::V1::Yelp::VenueInfoController < ApplicationController
    def find_venue 
        data = VenueSearchFacade.venue_search(params[:term], params[:location])
        
        render json: VenuePoroSerializer.new(data)
     end 
end 