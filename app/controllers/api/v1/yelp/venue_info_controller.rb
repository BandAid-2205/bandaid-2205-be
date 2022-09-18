class Api::V1::Yelp::VenueInfoController < ApplicationController
    def find_venue 
        data = VenueSearchFacade.venue_search(params[:term], params[:location])
      
        if data.first.class == VenuePoro 
           json_response(data) 
        else 
            error_handle(data)
        end 
    end 

    private 
        def json_response(object, status = :ok)
            render json: VenuePoroSerializer.new(object), status: status
        end

        def error_handle(object)
            render json: object[:error][:description], status: 404
        end 
end 