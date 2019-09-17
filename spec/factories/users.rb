FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { FFaker::Internet.unique.email }
    password { 'gogogogo' }
  end
end
