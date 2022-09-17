class Venue < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location
  validates_presence_of :phone
  validates_presence_of :price 
  validates_presence_of :category 
  validate :rating 
  validates_numericality_of :rating
  validates_presence_of :user_id

  has_many :events
end
