require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:phone) }
    # it { should validate_format_of(:phone).with(/\d[0-9]\)*\z/) }
    it { should allow_value('$').for(:price) }
    it { should allow_value('$$').for(:price) }
    it { should allow_value('$$$').for(:price) }
    it { should allow_value('$$$$').for(:price) }
    it { should validate_presence_of(:category).allow_nil }
    it { should validate_numericality_of(:rating).allow_nil }
    it { should validate_presence_of(:rating).allow_nil }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should have_many(:venue_artists) }
    it { should have_many(:artists).through(:venue_artists) }
  end

  describe 'model methods' do
    describe '#find_venue' do
      it 'scopes venues with fuzzy search by location' do
        create_list(:venue, 5)

        location_search = Venue.first.location

        Venue.find_venue(location_search).each do |venue|
          expect(location_search).to eq(venue.location)
        end
      end

      it 'returns empty if no search matches location' do
        create_list(:venue, 5)

        location_search = 'jdfsnfhe'

        Venue.find_venue(location_search).each do |venue|
          expect(location_search).to eq nil
        end
      end
    end
  end
end
