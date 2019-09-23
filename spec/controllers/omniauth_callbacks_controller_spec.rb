require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe '#facebook' do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    end

    it 'should successfully create a user' do
      expect{ post :facebook }.to change{ User.count }.by(1)
    end

    it 'should redirect the user to the root url' do
      post :facebook
      expect(response).to redirect_to root_path
    end
  end

  describe '#google_oauth2' do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end

    it 'should successfully create a user' do
      expect{ post :google_oauth2 }.to change{ User.count }.by(1)
    end

    it 'should redirect the user to the root url' do
      post :google_oauth2
      expect(response).to redirect_to root_path
    end
  end
end
