FactoryBot.define do
  factory :venue do
    name { Faker::Company.name }
    location { Faker::Address.full_address }
    phone { Faker::PhoneNumber.cell_phone }
    price { ['$', '$$', '$$$'].sample }
    category { Faker::Types.rb_array(len: 2) }
    rating { Faker::Number.within(range: 1..5) }
    user_id { Faker::Number.within(range: 50..75) }
  end
end
