FactoryBot.define do
  factory :purchase_record_shipping_address do
    post_code { Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building_name { Faker::Company.name }
    telephone_number { Faker::Number.leading_zero_number(digits: 11) }
    token { Faker::Alphanumeric.alphanumeric(number: 30) }
    association :user
    association :item
  end
end
