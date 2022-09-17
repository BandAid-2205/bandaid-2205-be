require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    it { should validate_presence_of :bio }
    it { should validate_presence_of :genres }
    it { should validate_presence_of :image_path }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should have_many(:artist_events) }
    it { should have_many(:events).through(:artist_events) }
  end

  describe 'model methods' do
    describe '#find_artist' do
      it 'scopes artists with fuzzy search by name' do
        create_list(:artist, 5)

        name_search = Artist.first.name

        Artist.find_artist(name_search).each do |artist|
          expect(name_search).to eq(artist.name)
        end
      end

      it 'returns empty if no search matches name' do
        create_list(:artist, 5)

        name_search = 'Junk'

        Artist.find_artist(name_search).each do |artist|
          expect(name_search).to eq nil
        end
      end
    end
  end
end
