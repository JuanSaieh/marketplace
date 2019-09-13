require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #index' do
    before do
      create_list(:user, 2)
      get :index
    end

    it 'returns succssfully' do
      expect(response).to be_successful
    end

    it 'follows the routes successfully' do
      expect(controller.controller_path).to eq('users')
    end

    it 'renders the index template' do
      expect(response).to render_template("index")
    end

    it 'compares that all users in the table are equal to the index instance variable' do
      expect(User.all).to match(assigns(:users))
    end
  end

  describe 'GET #new' do
    before do
      get :new
    end
    
    it 'returns succssfully' do
      expect(response).to be_successful
    end

    it 'proves that @user was instantiated correctly' do
      expect(controller.instance_variable_get(:@user)).to be_a_new(User)
    end
  end

  describe 'POST users#create' do
    context 'when user is valid' do
      before do
        post :create, params: { user: FactoryBot.attributes_for(:user) }
      end

      it 'assigns a newly created user as @user' do
        expect(controller.instance_variable_get(:@user)).to be_a(User)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'redirect 302' do
        expect(response).to have_http_status(302)
      end
    end

    context 'when user is invalid' do
      before do
        post :create, params: { user: { first_name: 'j', last_name: 's'} }
      end

      it 'renders new' do
        expect(subject).to render_template(:new)
      end

      it 'does not redirect to root_path' do
        expect(subject).to_not redirect_to(root_path)
      end
    end
  end

  describe 'GET #show' do
    before do
      create(:user)
      get :show, params: { id: User.first.id }
    end

    it 'returns succssfully' do
      expect(response).to be_successful
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns @user correctly' do
      expect(controller.instance_variable_get(:@user)).to eql(User.first)
    end
  end

  describe 'DELETE #destroy' do
    before do
      create_list(:user, 2)
    end

    context 'when user is signed in' do
      it 'assigns allow_action to true' do
        sign_in User.first
        delete :destroy, params: { id: User.first.id }
        expect(controller.instance_variable_get(:@allow_action)).to be_truthy
      end

      it 'tries to delete user that is not logged in and assigns allow_action to be falsy' do
        delete :destroy, params: { id: User.last.id }
        expect(controller.instance_variable_get(:@allow_action)).to be_falsy
      end

      it 'validates that the user was deleted' do
        sign_in User.first
        delete :destroy, params: { id: User.first.id }
        expect(User.all).to_not include(controller.instance_variable_get(:@user))
      end
    end
    
    context 'when user is not signed in' do
      it 'assigns allow_action to be falsy' do
        delete :destroy, params: { id: User.first.id }
        expect(controller.instance_variable_get(:@allow_action)).to be_falsy
      end
    end
  end
end
