class Artist < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location
  validates_presence_of :bio, allow_nil: true
  validates_presence_of :genre
  validates_presence_of :image_path, allow_nil: true
  validates :image_path, allow_blank: true, format: { with: %r{.(gif|jpg|png)\Z}i, message: 'must be a URL for GIF, JPG or PNG image.' }
  validates_presence_of :user_id, unique: true

  has_many :venue_artists, dependent: :destroy
  has_many :venues, through: :venue_artists

  def bookings
    self.venues.references(:venue_artists).pluck(:user_id, :name, :booking_status).map { |user_id, name, booking_status| {id: user_id, venue_name: name, booking_status: booking_status}}
  end
end
