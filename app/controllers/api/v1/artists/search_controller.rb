class Api::V1::Artists::SearchController < ApplicationController
  before_action :param_validation

   def show
     artists = Artist.find_artist(params[:name]).order(:name)
     if artists.empty?
       render json: { data: {message: 'Artist not found'} }
     else
       render json: ArtistSerializer.new(artists.first)
     end
   end

  private
  def param_validation
    if !params[:query].present?
      render json: { data: {} }, status: 400
    end
  end
end
