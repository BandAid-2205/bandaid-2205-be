class Api::V1::VenuesController < ApplicationController
  def index
    render json: VenueSerializer.new(Venue.all)
  end

  def create
    venue = Venue.create!(venue_params)
    venue_json_response(venue)
  end

  def show
    venue = Venue.find_by!(user_id: params[:id])
    venue_json_response(venue)
  end

  def update
    venue = Venue.find_by!(user_id: params[:id])
    venue.update_attributes!(venue_params)
    venue_json_response(venue)
  end

  def destroy
    venue = Venue.find_by!(user_id: params[:id])
    render json: Venue.destroy(venue.id)
    head :no_content
  end

  private
    def venue_params
      params.require(:venue).permit(:name, :location, :phone, :price, :rating, :category, :user_id)
    end
end
