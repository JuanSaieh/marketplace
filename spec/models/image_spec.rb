require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:imageable) }
  end

  before { create(:image) }

  describe 'Attachment' do
    it 'is valid' do
      expect(Image.last).to be_valid
    end

    it 'has Attachment' do
      expect(Image.last.avatar).to be_attached
    end

    it 'has file name' do
      expect(Image.last.avatar.filename).to eq('horse.jpg')
    end
  end
end
