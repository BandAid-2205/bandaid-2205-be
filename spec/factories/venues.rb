FactoryBot.define do
  factory :venue do
    name { Faker::Company.name }
    location { Faker::Address.full_address }
    phone { Faker::PhoneNumber.cell_phone }
    price { Faker::Commerce.price(range: 0..10.0, as_string: true) }
    category { Faker::Company.industry }
    rating { Faker::Number.within(range: 1..5) }
    user_id { Faker::Number.within(range: 50..75) }
  end
end
