class Api::V1::Venues::SearchController < ApplicationController
  def index
    venues = Venue.find_venue(params[:location]).order(:location)
    if !params[:location].present?
      render json: { data: {} }, status: 400
    elsif !venues.empty?
      render json: VenueSerializer.new(venues)
    else
      render json: { data: [] }, status: 400
    end
  end
end
