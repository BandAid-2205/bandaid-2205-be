module Response 
  def venue_json_response(object, status = :ok)
    if object == nil 
      render json: VenueSerializer.new(object), status: status 
    else 
      render json: VenueSerializer.new(object), status: status 
    end
  end

  def error_response(message, status)
    render json: message, status: status  
  end
end