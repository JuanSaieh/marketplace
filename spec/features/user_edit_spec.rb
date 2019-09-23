require 'rails_helper'

RSpec.feature "UserEdits", type: :feature do
  let(:user) { create(:user) }
  
  context 'If user is signed in' do
    before do
      sign_in(user)
      visit edit_user_registration_path
    end

    it 'validates that current password can`t be blank' do
      fill_in 'Address', with: 'Cra 53'
      click_button 'Update'
      expect(page).to have_content('Current password can\'t be blank')
    end

    it 'updates user if current password is given' do
      fill_in 'Current password', with: 'gogogogo'
      fill_in 'Address', with: 'Cra 53'
      click_button 'Update'
      expect(User.first.address).to eql('Cra 53')
    end

    it 'deletes user when clicked on Cancel my account' do
      expect{
        click_button 'Cancel my account'
      }.to change{ User.count }.by(-1)
    end

    it 'needs to have a password of 8 characters' do
      fill_in 'Password', with: 'asdasd'
      fill_in 'Password confirmation', with: 'asdasd'
      fill_in 'Current password', with: 'gogogogo'
      click_button 'Update'
      expect(page).to have_content('Password is too short')
    end

    it 'needs to have a password of 8 characters' do
      fill_in 'Password', with: 'asdasdas'
      fill_in 'Password confirmation', with: 'asdasdas'
      fill_in 'Current password', with: 'gogogogo'
      click_button 'Update'
      expect(page).to have_content('Your account has been updated successfully')
    end
  end

  context 'If there is no user signed in' do
    it 'tries to edit user' do
      visit edit_user_registration_path
      expect(page).to have_content('You need to sign in or sign up before continuing')
    end  
  end
end
