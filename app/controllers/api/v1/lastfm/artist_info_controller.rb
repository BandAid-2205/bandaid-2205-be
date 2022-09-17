class Api::V1::Lastfm::ArtistInfoController < ApplicationController
  def find_artist
    data = ArtistSearchFacade.artist_search(params[:query])
    if data.class == ArtistPoro
      json_response(data) 
    else 
      error_handle(data)
    end
  end

   private 
      def json_response(object, status = :ok)
        if object == nil 
          render json: { data: {}}
        else
          render json: ArtistPoroSerializer.new(object), status: status
        end
      end

      def error_handle(object)
        # object = {:error=>6, :message=>"The artist you supplied could not be found", :links=>[]}
        render json: object[:message], status: 404
      end
  end
end 
