module Response
  def venue_json_response(object, status = :ok)
    render json: VenueSerializer.new(object, include: [:artists, :venue_artists]), status: status
  end

  def artist_json_response(object, status = :ok)
    render json: ArtistSerializer.new(object, include: [:venues, :venue_artists]), status: status
  end

  def venue_artist_json_response(object, status = :ok)
    render json: VenueArtistSerializer.new(object), status: status
  end

  def error_response(message, status)
    render json: message, status: status
  end
end
