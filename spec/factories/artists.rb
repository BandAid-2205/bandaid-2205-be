FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    location { Faker::Address.full_address }
    bio { Faker::Lorem.paragraph }
    genres { Faker::Types.rb_array(len: 2) }
    image_path { Faker::LoremPixel.image }
    user_id { Faker::Number.within(range: 50..75) }
  end
end
