FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "shoe#{n}" }
    description { 'red' }
    quantity { 5 }
    price { 50_000 }
    user
    category
  end
end
