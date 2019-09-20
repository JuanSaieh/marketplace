FactoryBot.define do
  factory :product do
    name { 'Shoe' }
    description { 'red' }
    quantity { 5 }
    price { 50_000 }
    user
    category
  end
end
