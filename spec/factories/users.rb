FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "John#{n}" }
    last_name { 'Doe' }
    email { FFaker::Internet.unique.email }
    password { 'gogogogo' }
  end
end
