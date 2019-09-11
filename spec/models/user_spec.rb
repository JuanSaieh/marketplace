require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should_not validate_presence_of(:cellphone) }
  it { should respond_to(:name) }
  it { should have_many(:products) }
  it { should accept_nested_attributes_for(:products) }
  describe '.new' do
    it { is_expected.to be_a_new(User) }
  end

  let(:user) { create(:user) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:arr) { [user1, user2] }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe '#name returns a string' do
    it { expect(user.name).to eql('John Doe') }
  end

  describe '#expect_me' do
    context 'No other Users exist' do
      it { expect(User.except_me(user)).to match_array(Array.new(0)) }
    end

    context 'Users exist' do
      it { expect(User.except_me(user)).to match_array(arr) }
    end
  end

end
