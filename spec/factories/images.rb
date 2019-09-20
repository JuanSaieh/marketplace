FactoryBot.define do
  factory :image do
    avatar { fixture_file_upload("spec/assets/horse.jpg", 'image/png') }
    association(:imageable, factory: :product)
  end
end
