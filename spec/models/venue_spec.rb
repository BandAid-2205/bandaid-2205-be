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

  describe 'venue instance methods' do
    it 'has attribute bookings that lists artists name and booking status' do
      artists = create_list(:artist, 5)
      artist1 = Artist.first
      artist2 = Artist.second
      artist3 = Artist.third
      artist4 = Artist.fourth
      artist5 = Artist.fifth
      venues = create_list(:venue, 3)
      venue1 = Venue.first
      venue2 = Venue.second
      venue3 = Venue.third

      v1a1 = VenueArtist.create!(
        venue_id: venue1.id,
        artist_id: artist1.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v1a4 = VenueArtist.create!(
        venue_id: venue1.id,
        artist_id: artist4.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v2a2 = VenueArtist.create!(
        venue_id: venue2.id,
        artist_id: artist2.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
      )
      v2a4 = VenueArtist.create!(
        venue_id: venue2.id,
        artist_id: artist4.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v3a1 = VenueArtist.create!(
        venue_id: venue3.id,
        artist_id: artist1.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v3a3 = VenueArtist.create!(
        venue_id: venue3.id,
        artist_id: artist3.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
      )
      v3a5 = VenueArtist.create!(
        venue_id: venue3.id,
        artist_id: artist5.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
      )
      venues.each do |venue|
        venue.bookings.each do |booking|
          expect(booking).to have_key(:id)
          expect(booking).to have_key(:booking_status)
          expect(booking).to have_key(:artist_name)
          expect(booking[:booking_status]).to be_an Integer
        end
      end
    
      expect(venue1.bookings[0][:id]).to eq(artist1.user_id)
      expect(venue1.bookings[0][:artist_name]).to eq(artist1.name)
      expect(venue1.bookings[1][:id]).to eq(artist4.user_id)
      expect(venue1.bookings[1][:artist_name]).to eq(artist4.name)
      expect(venue2.bookings[0][:id]).to eq(artist2.user_id)
      expect(venue2.bookings[0][:artist_name]).to eq(artist2.name)
      expect(venue2.bookings[1][:id]).to eq(artist4.user_id)
      expect(venue2.bookings[1][:artist_name]).to eq(artist4.name)
      expect(venue3.bookings[0][:id]).to eq(artist1.user_id)
      expect(venue3.bookings[0][:artist_name]).to eq(artist1.name)
      expect(venue3.bookings[1][:id]).to eq(artist3.user_id)
      expect(venue3.bookings[1][:artist_name]).to eq(artist3.name)
      expect(venue3.bookings[2][:id]).to eq(artist5.user_id)
      expect(venue3.bookings[2][:artist_name]).to eq(artist5.name)
    end
  end
end
