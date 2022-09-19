require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:bio).allow_nil }
    it { should validate_presence_of :genre }
    it { should validate_presence_of(:image_path).allow_nil }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should have_many(:artist_events) }
    it { should have_many(:events).through(:artist_events) }
    it { should have_many(:venue_artists) }
    it { should have_many(:venues).through(:venue_artists) }
  end
end
