require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe '.sending_mail' do
    before do
      create(:product)
      @email = UserMailer.send_mail(User.first, Product.first).deliver_now
    end

    it 'has host email assigned correctly' do
      expect('admin@marketplace.com').to eq(@email.from.first)
    end

    it 'has recipient assigned correctly' do
      expect(User.first.email).to eq(@email.to.first)
    end

    it 'has a subject' do
      expect('New Products in stock!').to eq(@email.subject)
    end
  end
end
