require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:bio).allow_nil }
    it { should validate_presence_of :genre }
    it { should validate_presence_of(:image_path).allow_nil }
    # it { should validate_format_of(:image_path).with(%r{.(gif|jpg|png)\Z}i) }
    it { should validate_presence_of :user_id }
  end

  describe 'relationships' do
    it { should have_many(:venue_artists) }
    it { should have_many(:venues).through(:venue_artists) }
  end

  describe 'instance methods' do
    it 'lists the attributes of other models on join' do
      artists = create_list(:artist, 2)
      artist1 = Artist.first
      artist2 = Artist.second
      venues = create_list(:venue, 4)
      venue1 = Venue.first
      venue2 = Venue.second
      venue3 = Venue.third
      venue4 = Venue.fourth
      v1a1 = VenueArtist.create!(
        artist_id: artist1.id,
        venue_id: venue1.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v2a1 = VenueArtist.create!(
        artist_id: artist1.id,
        venue_id: venue2.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v3a1 = VenueArtist.create!(
        artist_id: artist1.id,
        venue_id: venue3.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v2a2 = VenueArtist.create!(
        artist_id: artist2.id,
        venue_id: venue2.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      v4a2 = VenueArtist.create!(
        artist_id: artist2.id,
        venue_id: venue4.id,
        booking_status: ['pending', 'accepted', 'rejected'].sample
        )
      artists.each do |artist|
        artist.bookings.each do |booking|
          expect(booking).to have_key(:booking_status)
          expect(booking).to have_key(:venue_name)
          expect(booking[:booking_status]).to be_an Integer
        end
      end
      expect(artist1.bookings[0][:venue_name]).to eq(venue1.name)
      # expect(artist1.bookings[0][:booking_status]).to eq(v1a1.booking_status)
      expect(artist1.bookings[1][:venue_name]).to eq(venue2.name)
      # expect(artist1.bookings[1][:booking_status]).to eq(v2a1.booking_status)
      expect(artist1.bookings[2][:venue_name]).to eq(venue3.name)
      expect(artist2.bookings[0][:venue_name]).to eq(venue2.name)
      expect(artist2.bookings[1][:venue_name]).to eq(venue4.name)
    end
  end
end
