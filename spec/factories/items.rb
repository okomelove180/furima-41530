FactoryBot.define do
  factory :item do
    association :user
    product_name { Faker::Commerce.product_name }
    product_description { Faker::Lorem.paragraph }
    category_id { Faker::Number.between(from: 2, to: 11) }
    product_condition_id { Faker::Number.between(from: 2, to: 7) }
    shipping_cost_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    delivery_time_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'sample-image.png')), filename: 'sample-image.png',
                        content_type: 'image/png')
    end
  end
end
