FactoryBot.define do
  factory :artist_event do
    artist { create(:artist) }
    event { create(:event) }
  end
end
