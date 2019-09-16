require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:price) }
  end
  describe 'relations' do
    it { should belong_to(:category).class_name('Category') }
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:images) }
    it { should accept_nested_attributes_for(:images) }
  end
end
