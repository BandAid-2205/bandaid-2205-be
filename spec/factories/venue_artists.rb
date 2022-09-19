FactoryBot.define do
  factory :venue_artist do
    artist { create(:artist) }
    venue { create(:venue) }
    booking_status { ['pending', 'accepted', 'rejected'].sample }
  end
end
