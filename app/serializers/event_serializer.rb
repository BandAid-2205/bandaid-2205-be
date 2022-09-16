class EventSerializer
  include JSONAPI::Serializer
  attributes :name, :date, :start_time, :end_time, :booking_status, :venue_id
end
