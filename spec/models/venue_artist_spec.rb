require 'rails_helper'

RSpec.describe VenueArtist, type: :model do
  describe 'validations' do
    it { should validate_presence_of :booking_status }
    it { should allow_value('pending').for(:booking_status) }
    it { should allow_value('accepted').for(:booking_status) }
    it { should allow_value('rejected').for(:booking_status) }
  end

  describe 'relationships' do
    it { should belong_to :venue }
    it { should belong_to :artist }
  end
end
