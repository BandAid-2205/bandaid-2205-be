class Venue < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location
  validates_presence_of :phone
  validates_format_of :phone, :with =>  /\d[0-9]\)*\z/ #US only
  # validates :phone, format: { with: /\A\(?\d{3}\)?[- ]?\d{3}[- ]?\d{4}\z/ }
  validates :price, inclusion: ['$', '$$', '$$$', '$$$$']
  validates_presence_of :category, allow_nil: true
  validates_presence_of :rating, allow_nil: true
  validates_numericality_of :rating, allow_nil: true
  validates_presence_of :user_id

  has_many :venue_artists, dependent: :destroy
  has_many :artists, through: :venue_artists

  scope :find_venue,  -> (location) {where('location ILIKE ?', "%#{location}%")}

  def bookings
    self.artists.references(:venue_artists).pluck(:user_id, :name, :booking_status).map { |user_id, name, booking_status| {id: user_id, artist_name: name, booking_status: booking_status}}
  end
end
