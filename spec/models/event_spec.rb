require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :date }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :end_time }
    it { should validate_presence_of :booking_status }
    it { should validate_presence_of :venue_id }
  end

  describe 'relationships' do
    it { should have_many(:artist_events) }
    it { should have_many(:artists).through(:artist_events) }
    it { should belong_to :venue }
  end
end
