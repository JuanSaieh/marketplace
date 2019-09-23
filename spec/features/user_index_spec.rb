require 'rails_helper'

RSpec.feature "UserIndex", type: :feature do
  before { create_list(:user, 5) }

  context 'with logged in user' do
    it 'signs up a user and shows in index page' do
      visit new_user_registration_path
      fill_in 'First name', with: 'John'
      fill_in 'Last name', with: 'Doe'
      fill_in 'Email', with: FFaker::Internet.unique.email
      fill_in 'Password', with: 'gogogogo'
      fill_in 'Password confirmation', with: 'gogogogo'
      click_button 'Sign up'
      visit users_path
      expect(page).to have_content('John')
    end

    it 'deletes logged in user' do
      user = User.last
      sign_in(user)
      visit users_path
      click_link 'Delete'
      expect(page).to_not have_content(user.first_name)
    end
  end

  context 'without logged in user' do
    it 'shows all users in index page' do
      visit users_path
      expect(page.find("##{User.first.id}")).to have_content(User.first.first_name)
      expect(page.find("##{User.last.id}")).to have_content(User.last.first_name)
    end
  end
end
