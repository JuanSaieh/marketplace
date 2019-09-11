FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    sequence(:email) { |n| "Email#{n}@example.com" }
    password { 'gogogogo' }
  end
end
