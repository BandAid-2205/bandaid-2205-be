class Artist < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location
  validate :bio # optional
  validates_presence_of :genres # check boxes (select all that apply) 
  validate :image_path # optional 
  validates_presence_of :user_id

  has_many :artist_events, dependent: :destroy
  has_many :events, through: :artist_events

  scope :find_artist,  -> (name) {where('name ILIKE ?', "%#{name}%")}
end
